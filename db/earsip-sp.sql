CREATE FUNCTION update_menu_akses (_menu_id INT, _grup_id INT, _hak_akses_id INT) RETURNS VOID AS
$$
BEGIN
	LOOP
		UPDATE	menu_akses
		SET		hak_akses_id	= _hak_akses_id
		WHERE	menu_id			= _menu_id
		and		grup_id			= _grup_id;
		IF found THEN
			RETURN;
		END IF;
		BEGIN
			INSERT INTO	menu_akses (menu_id, grup_id, hak_akses_id)
			VALUES (_menu_id, _grup_id, _hak_akses_id);
			RETURN;
		EXCEPTION WHEN unique_violation THEN
			-- do nothing, and loop to try the UPDATE again
		END;
	END LOOP;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION public.get_berkas_path(_berkas_id integer)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
declare _id int;
declare _nama varchar (255);
begin
	if _berkas_id = 0 then
		return '';
	end if;

	select	pid
	,		nama
	into	_id, _nama
	from	m_berkas
	where	id = _berkas_id;

	return get_berkas_path (_id) || '/' || _nama;
end;
$function$;


CREATE OR REPLACE FUNCTION public.datediff (units VARCHAR(30), start_t TIMESTAMP, end_t TIMESTAMP) 
     RETURNS INT AS $$
   DECLARE
     diff_interval INTERVAL; 
     diff INT = 0;
     years_diff INT = 0;
   BEGIN
     IF units IN ('yy', 'yyyy', 'year', 'mm', 'm', 'month') THEN
       years_diff = DATE_PART('year', end_t) - DATE_PART('year', start_t);
 
       IF units IN ('yy', 'yyyy', 'year') THEN
         -- SQL Server does not count full years passed (only difference between year parts)
         RETURN years_diff;
       ELSE
         -- If end month is less than start month it will subtracted
         RETURN years_diff * 12 + (DATE_PART('month', end_t) - DATE_PART('month', start_t)); 
       END IF;
     END IF;
 
     -- Minus operator returns interval 'DDD days HH:MI:SS'  
     diff_interval = end_t - start_t;
 
     diff = diff + DATE_PART('day', diff_interval);
 
     IF units IN ('wk', 'ww', 'week') THEN
       diff = diff/7;
       RETURN diff;
     END IF;
 
     IF units IN ('dd', 'd', 'day') THEN
       RETURN diff;
     END IF;
 
     diff = diff * 24 + DATE_PART('hour', diff_interval); 
 
     IF units IN ('hh', 'hour') THEN
        RETURN diff;
     END IF;
 
     diff = diff * 60 + DATE_PART('minute', diff_interval);
 
     IF units IN ('mi', 'n', 'minute') THEN
        RETURN diff;
     END IF;
 
     diff = diff * 60 + DATE_PART('second', diff_interval);
 
     RETURN diff;
   END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION public.dateadd(diffType Character Varying(15), incrementValue int, inputDate timestamp) RETURNS timestamp AS $$
DECLARE
   YEAR_CONST Char(15) := 'year';
   MONTH_CONST Char(15) := 'month';
   DAY_CONST Char(15) := 'day';

   dateTemp Date;
   intervals interval;
BEGIN
   IF lower($1) = lower(YEAR_CONST) THEN
       select cast(cast(incrementvalue as character varying) || ' year' as interval) into intervals;
   ELSEIF lower($1) = lower(MONTH_CONST) THEN
       select cast(cast(incrementvalue as character varying) || ' months' as interval) into intervals;
   ELSEIF lower($1) = lower(DAY_CONST) THEN
       select cast(cast(incrementvalue as character varying) || ' day' as interval) into intervals;
   END IF;

   dateTemp:= inputdate + intervals;

   RETURN dateTemp;
END;
$$ LANGUAGE plpgsql;

