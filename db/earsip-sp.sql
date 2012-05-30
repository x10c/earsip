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
$$
LANGUAGE plpgsql;

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
	,	nama
	into	_id, _nama
	from	m_berkas
	where	id = _berkas_id;

	return get_berkas_path (_id) || '/' || _nama;
end;
$function$
