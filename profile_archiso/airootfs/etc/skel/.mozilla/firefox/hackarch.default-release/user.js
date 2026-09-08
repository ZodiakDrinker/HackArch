// --- MODO OSCURO & TEMA ---
user_pref("ui.systemUsesDarkTheme", 1);
user_pref("layout.css.prefers-color-scheme.content-override", 0);
user_pref("browser.theme.content-theme", 0);
user_pref("browser.theme.toolbar-theme", 0);

// --- CONFIGURACIÓN DE PROXY PAC & INTERCEPCIÓN LOCAL ---
user_pref("network.proxy.type", 2);
user_pref("network.proxy.autoconfig_url", "file:///home/zodiak/.config/i2pd/proxy.pac");

// DESBLOQUEO CRÍTICO: Permitir interceptar y tunelizar tráfico hacia localhost y 127.0.0.1
user_pref("network.proxy.allow_hijacking_localhost", true);
user_pref("network.proxy.no_proxies_on", ""); // Dejar vacío para que localhost no quede excluido del proxy

// EVITAR BÚSQUEDA AUTOMÁTICA EN GOOGLE AL ESCRIBIR DOMINIOS .HTB
user_pref("browser.fixup.domainsuffixwhitelist.htb", true);
user_pref("keyword.enabled", true);

// DESACTIVAR PANTALLAS DE BIENVENIDA Y TOUR
user_pref("browser.startup.homepage_override.mstone", "ignore");
user_pref("startup.homepage_welcome_url", "");
