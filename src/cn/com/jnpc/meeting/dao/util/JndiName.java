package cn.com.jnpc.meeting.dao.util;

/**
 * 数据源名称
 * 
 * @ClassName: DataSourceName
 * @Title:
 * @Author:linuke
 * @Since:2013-4-19下午3:37:41
 * @Version:1.0
 */
public enum JndiName {
    JNPC("jdbc/jnpctemp"), INTRAWEB("jdbc/intraweb"),TEMP("jdbc/jnpctemp");
//JNPC("jdbc/jnpc"),
    private String jndiName;

    JndiName(String jndiName) {
        this.jndiName = jndiName;
    }

    public String getJndiName() {
        return jndiName;
    }

}