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
