package org.sirr;
import java.util.Map;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionBindingEvent;


public class ActiveUser implements HttpSessionBindingListener {

    // All logins.
    private static Map<ActiveUser, HttpSession> logins = new HashMap<ActiveUser, HttpSession>();
	
    // Normal properties.
    private Long id;
    // Etc.. Of course with public getters+setters.
	
	public ActiveUser (Long id) {
		this.id = id; 
	}
	
	
	public Long getId () {
		return id ;
	}
	
    @Override
    public boolean equals(Object other) {
        return (other instanceof ActiveUser) && (id != null) ? id.equals(((ActiveUser) other).id) : (other == this);
    }

    @Override
    public int hashCode() {
        return (id != null) ? (this.getClass().hashCode() + id.hashCode()) : super.hashCode();
    }

    @Override
    public void valueBound(HttpSessionBindingEvent event) {
			

        HttpSession session = logins.remove(this);
        if (session != null) {
			System.out.println (session.getId ());
            session.removeAttribute ("user");
			session.removeAttribute ("user.id");
			session.removeAttribute ("user.unit_kerja_id");
			session.removeAttribute ("user.grup_id");
			session.removeAttribute ("user.nama");
			session.removeAttribute ("user.nip");
        }
        logins.put(this, event.getSession());
		
    }

    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        logins.remove(this);
    }

}