$rootDir = "c:\Users\zmarq\OneDrive\Desktop\PAG-WEB-FIRMA"

$pages = @(
    @{ path = "nuestra-firma"; title = "Nuestra Firma"; depth = 1; type = "about" },
    @{ path = "blog"; title = "Blog"; depth = 1; type = "blog" },
    @{ path = "contacto"; title = "Contacto"; depth = 1; type = "contact" },
    @{ path = "servicios"; title = "Servicios"; depth = 1; type = "services-main" },
    @{ path = "servicios\propiedad-horizontal"; title = "Propiedad Horizontal"; depth = 2; type = "service"; icon="fa-building" },
    @{ path = "servicios\urbanismo-e-inmobiliario"; title = "Urbanismo e Inmobiliario"; depth = 2; type = "service"; icon="fa-city" },
    @{ path = "servicios\derecho-corporativo"; title = "Derecho Corporativo"; depth = 2; type = "service"; icon="fa-briefcase" },
    @{ path = "servicios\derecho-civil"; title = "Derecho Civil"; depth = 2; type = "service"; icon="fa-gavel" },
    @{ path = "servicios\derecho-administrativo"; title = "Derecho Administrativo"; depth = 2; type = "service"; icon="fa-landmark" },
    @{ path = "servicios\derecho-laboral"; title = "Derecho Laboral"; depth = 2; type = "service"; icon="fa-user-tie" }
)

foreach ($p in $pages) {
    $dir = Join-Path $rootDir $p.path
    $relativePath = ""
    for ($i = 0; $i -lt $p.depth; $i++) { $relativePath += "../" }

    $title = $p.title
    $type = $p.type
    $icon = if ($p.icon) { $p.icon } else { "fa-balance-scale" }

    # Base Head
    $htmlHead = @"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title | BCOM Abogados</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${relativePath}styles.css">
    <style>
        .inner-hero {
            background: linear-gradient(100deg, rgba(15, 23, 42, 0.95) 0%, rgba(15, 23, 42, 0.8) 100%), url('https://images.unsplash.com/photo-1589829085413-56de8ae18c73?q=80&w=2000&auto=format&fit=crop') center/cover;
            padding: 160px 0 100px;
            color: white;
            text-align: center;
        }
        .hero-title { font-size: 3.5rem; margin-bottom: 1rem; }
        .hero-subtitle { font-size: 1.2rem; opacity: 0.9; color: var(--color-accent); }
        
        /* Layout specific styles */
        .content-section { padding: var(--section-padding); }
        .grid-2-cols { display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center; }
        .grid-3-cols { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2.5rem; }
        .grid-layout { display: grid; grid-template-columns: 2.5fr 1fr; gap: 4rem; }
        
        /* Cards & Features */
        .feature-card { background: var(--color-bg-white); padding: 2.5rem; border-radius: var(--radius-lg); box-shadow: var(--shadow-sm); border-top: 4px solid var(--color-accent); transition: var(--transition); height: 100%;}
        .feature-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-lg); }
        .feature-icon { font-size: 2.5rem; color: var(--color-accent); margin-bottom: 1.5rem; }
        
        /* Blog Cards */
        .blog-card { background: var(--color-bg-white); border-radius: var(--radius-lg); overflow: hidden; box-shadow: var(--shadow-md); height: 100%;}
        .blog-img { width: 100%; height: 250px; object-fit: cover; }
        .blog-content { padding: 2rem; }
        .blog-date { color: var(--color-accent); font-size: 0.9rem; font-weight: 600; margin-bottom: 0.5rem; display: block; }
        
        /* Forms */
        .contact-form { display: flex; flex-direction: column; gap: 1.5rem; background: var(--color-bg-white); padding: 3rem; border-radius: var(--radius-lg); box-shadow: var(--shadow-md); }
        .form-group input, .form-group textarea { width: 100%; padding: 1rem; border: 1px solid #e2e8f0; border-radius: var(--radius-md); font-family: var(--font-body); }
        
        /* Sidebar */
        .sidebar { background: #f8fafc; padding: 2.5rem; border-radius: 12px; border: 1px solid #e2e8f0; position: sticky; top: 100px; text-align: center; height: fit-content; }
        .sidebar-icon { font-size: 3.5rem; color: var(--color-accent); margin-bottom: 1.5rem; }
        
        @media (max-width: 992px) {
            .grid-2-cols, .grid-layout { grid-template-columns: 1fr; }
            .sidebar { position: static; }
        }
    </style>
</head>
<body>
"@

    # Base Header
    $htmlHeader = @"
    <header id="main-header" class="glass-header">
        <div class="container header-container">
            <a href="${relativePath}index.html" class="logo">
                <span class="logo-bcom">BCOM</span>
                <span class="logo-abogados">ABOGADOS</span>
            </a>
            <nav class="main-nav">
                <ul class="nav-list">
                    <li class="nav-item has-dropdown">
                        <a href="${relativePath}servicios/index.html">Servicios <i class="fas fa-chevron-down"></i></a>
                        <ul class="dropdown">
                            <li><a href="${relativePath}servicios/propiedad-horizontal/index.html">Propiedad Horizontal</a></li>
                            <li><a href="${relativePath}servicios/urbanismo-e-inmobiliario/index.html">Urbanismo e Inmobiliario</a></li>
                            <li><a href="${relativePath}servicios/derecho-corporativo/index.html">Derecho Corporativo</a></li>
                            <li><a href="${relativePath}servicios/derecho-civil/index.html">Derecho Civil</a></li>
                            <li><a href="${relativePath}servicios/derecho-administrativo/index.html">Derecho Administrativo</a></li>
                            <li><a href="${relativePath}servicios/derecho-laboral/index.html">Derecho Laboral</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a href="${relativePath}nuestra-firma/index.html">Nuestra Firma</a></li>
                    <li class="nav-item"><a href="${relativePath}blog/index.html">Blog</a></li>
                    <li class="nav-item"><a href="${relativePath}contacto/index.html">Contacto</a></li>
                </ul>
            </nav>
            <div class="header-actions">
                <a href="${relativePath}contacto/index.html" class="btn btn-primary cta-agenda">Agenda una Asesoría</a>
            </div>
            <button class="mobile-menu-btn" aria-label="Abrir menú"><i class="fas fa-bars"></i></button>
        </div>
    </header>
"@

    $htmlBody = ""

    if ($type -eq "about") {
        $htmlBody = @"
    <section class="inner-hero">
        <div class="container">
            <h1 class="hero-title">$title</h1>
            <p class="hero-subtitle">Conoce al equipo detrás de nuestro éxito</p>
        </div>
    </section>
    
    <section class="content-section">
        <div class="container grid-2-cols">
            <div>
                <h2 style="font-size: 2.5rem; color: var(--color-primary); margin-bottom: 1.5rem;">Trayectoria y Excelencia</h2>
                <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 1.5rem;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis cursus mi ut leo sodales, ut interdum nunc egestas. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
                <p style="font-size: 1.1rem; line-height: 1.8;">Praesent vel felis justo. Cras vulputate bibendum arcu, sit amet consequat purus rhoncus ac. Suspendisse potenti. Nunc nec tortor in massa interdum condimentum a nec ante.</p>
            </div>
            <div>
                <img src="https://images.unsplash.com/photo-1556761175-5973dc0f32b7?q=80&w=1632&auto=format&fit=crop" style="width:100%; border-radius: var(--radius-lg); box-shadow: var(--shadow-lg);" alt="Nuestra Firma">
            </div>
        </div>
    </section>
    
    <section class="content-section" style="background: var(--color-bg-light);">
        <div class="container">
            <h2 class="text-center" style="font-size: 2.5rem; margin-bottom: 3rem;">Nuestros Valores</h2>
            <div class="grid-3-cols">
                <div class="feature-card text-center">
                    <i class="fas fa-shield-alt feature-icon"></i>
                    <h3>Integridad</h3>
                    <p style="margin-top: 1rem; color: var(--color-text-muted);">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce a nisi nec felis vulputate tincidunt.</p>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-gem feature-icon"></i>
                    <h3>Excelencia</h3>
                    <p style="margin-top: 1rem; color: var(--color-text-muted);">Proin fermentum sem id lorem vestibulum, sed sodales libero convallis. Donec pharetra odio et orci.</p>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-handshake feature-icon"></i>
                    <h3>Compromiso</h3>
                    <p style="margin-top: 1rem; color: var(--color-text-muted);">Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae.</p>
                </div>
            </div>
        </div>
    </section>
"@
    } elseif ($type -eq "blog") {
        $htmlBody = @"
    <section class="inner-hero">
        <div class="container">
            <h1 class="hero-title">Actualidad y $title</h1>
            <p class="hero-subtitle">Últimas noticias y artículos legales</p>
        </div>
    </section>
    
    <section class="content-section">
        <div class="container grid-3-cols">
            <!-- Article 1 -->
            <article class="blog-card">
                <img src="https://images.unsplash.com/photo-1505664159854-2326588009bc?q=80&w=1471&auto=format&fit=crop" class="blog-img" alt="Blog 1">
                <div class="blog-content">
                    <span class="blog-date">10 Octubre, 2026</span>
                    <h3 style="margin-bottom: 1rem;">Nuevas normativas de Propiedad Horizontal</h3>
                    <p style="color: var(--color-text-muted); margin-bottom: 1.5rem;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi tristique, sem quis tincidunt hendrerit...</p>
                    <a href="#" style="color: var(--color-accent); font-weight: 600;">Leer artículo <i class="fas fa-arrow-right"></i></a>
                </div>
            </article>
            <!-- Article 2 -->
            <article class="blog-card">
                <img src="https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2070&auto=format&fit=crop" class="blog-img" alt="Blog 2">
                <div class="blog-content">
                    <span class="blog-date">05 Octubre, 2026</span>
                    <h3 style="margin-bottom: 1rem;">Licencias de construcción: ¿Qué debes saber?</h3>
                    <p style="color: var(--color-text-muted); margin-bottom: 1.5rem;">Sed in risus ut lectus tempus ullamcorper. Vestibulum ut dolor id magna laoreet ullamcorper...</p>
                    <a href="#" style="color: var(--color-accent); font-weight: 600;">Leer artículo <i class="fas fa-arrow-right"></i></a>
                </div>
            </article>
            <!-- Article 3 -->
            <article class="blog-card">
                <img src="https://images.unsplash.com/photo-1450101499163-c8848c66cb85?q=80&w=1470&auto=format&fit=crop" class="blog-img" alt="Blog 3">
                <div class="blog-content">
                    <span class="blog-date">28 Septiembre, 2026</span>
                    <h3 style="margin-bottom: 1rem;">Contratos corporativos y blindaje legal</h3>
                    <p style="color: var(--color-text-muted); margin-bottom: 1.5rem;">Nullam in odio in est pellentesque hendrerit vel eu erat. Phasellus a sapien at justo iaculis eleifend...</p>
                    <a href="#" style="color: var(--color-accent); font-weight: 600;">Leer artículo <i class="fas fa-arrow-right"></i></a>
                </div>
            </article>
        </div>
    </section>
"@
    } elseif ($type -eq "contact") {
        $htmlBody = @"
    <section class="inner-hero">
        <div class="container">
            <h1 class="hero-title">$title</h1>
            <p class="hero-subtitle">Estamos aquí para escucharte y asesorarte</p>
        </div>
    </section>

    <section class="content-section">
        <div class="container grid-2-cols">
            <form class="contact-form">
                <h2 style="font-size: 2rem; color: var(--color-primary); margin-bottom: 1rem;">Envíanos un mensaje</h2>
                <div class="form-group">
                    <input type="text" placeholder="Nombre completo" required>
                </div>
                <div class="form-group">
                    <input type="email" placeholder="Correo electrónico" required>
                </div>
                <div class="form-group">
                    <input type="text" placeholder="Asunto" required>
                </div>
                <div class="form-group">
                    <textarea rows="5" placeholder="Tu mensaje..." required></textarea>
                </div>
                <button type="button" class="btn btn-primary" style="width: 100%;" onclick="alert('Mensaje enviado (Simulación)')">Enviar Mensaje</button>
            </form>
            
            <div>
                <h2 style="font-size: 2.5rem; color: var(--color-primary); margin-bottom: 1.5rem;">Información de $title</h2>
                <p style="font-size: 1.1rem; line-height: 1.8; margin-bottom: 2rem;">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse varius enim in eros elementum tristique. Duis cursus, mi quis viverra ornare.</p>
                <ul style="list-style: none; display: flex; flex-direction: column; gap: 1.5rem;">
                    <li style="display: flex; align-items: center; gap: 1rem; font-size: 1.2rem;">
                        <i class="fas fa-map-marker-alt" style="color: var(--color-accent); font-size: 1.5rem;"></i>
                        Cra. 17 #150-52 Oficina 303, Bogotá
                    </li>
                    <li style="display: flex; align-items: center; gap: 1rem; font-size: 1.2rem;">
                        <i class="fas fa-envelope" style="color: var(--color-accent); font-size: 1.5rem;"></i>
                        <a href="mailto:contactenos@bcomabogados.com">contactenos@bcomabogados.com</a>
                    </li>
                    <li style="display: flex; align-items: center; gap: 1rem; font-size: 1.2rem;">
                        <i class="fas fa-phone-alt" style="color: var(--color-accent); font-size: 1.5rem;"></i>
                        <a href="tel:+573108100727">310 810 07 27</a>
                    </li>
                </ul>
            </div>
        </div>
    </section>
"@
    } elseif ($type -eq "services-main") {
        $htmlBody = @"
    <section class="inner-hero">
        <div class="container">
            <h1 class="hero-title">$title</h1>
            <p class="hero-subtitle">Áreas de práctica y especialización</p>
        </div>
    </section>

    <section class="content-section" style="background: var(--color-bg-light);">
        <div class="container">
            <div class="grid-3-cols">
                <div class="feature-card text-center">
                    <i class="fas fa-building feature-icon"></i>
                    <h3>Propiedad Horizontal</h3>
                    <p style="margin: 1rem 0 1.5rem; color: var(--color-text-muted);">Asesoría integral para copropiedades, asambleas y administradores.</p>
                    <a href="propiedad-horizontal/index.html" class="btn btn-primary" style="width:100%;">Saber más</a>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-city feature-icon"></i>
                    <h3>Urbanismo e Inmobiliario</h3>
                    <p style="margin: 1rem 0 1.5rem; color: var(--color-text-muted);">Estructuración legal de proyectos constructivos y licencias.</p>
                    <a href="urbanismo-e-inmobiliario/index.html" class="btn btn-primary" style="width:100%;">Saber más</a>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-briefcase feature-icon"></i>
                    <h3>Derecho Corporativo</h3>
                    <p style="margin: 1rem 0 1.5rem; color: var(--color-text-muted);">Constitución de sociedades, gobierno corporativo y fusiones.</p>
                    <a href="derecho-corporativo/index.html" class="btn btn-primary" style="width:100%;">Saber más</a>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-gavel feature-icon"></i>
                    <h3>Derecho Civil</h3>
                    <p style="margin: 1rem 0 1.5rem; color: var(--color-text-muted);">Resolución de conflictos, litigio y manejo de obligaciones.</p>
                    <a href="derecho-civil/index.html" class="btn btn-primary" style="width:100%;">Saber más</a>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-landmark feature-icon"></i>
                    <h3>Derecho Administrativo</h3>
                    <p style="margin: 1rem 0 1.5rem; color: var(--color-text-muted);">Actuaciones ante entidades públicas y litigio contencioso.</p>
                    <a href="derecho-administrativo/index.html" class="btn btn-primary" style="width:100%;">Saber más</a>
                </div>
                <div class="feature-card text-center">
                    <i class="fas fa-user-tie feature-icon"></i>
                    <h3>Derecho Laboral</h3>
                    <p style="margin: 1rem 0 1.5rem; color: var(--color-text-muted);">Contratación, reglamentos y defensa integral en litigios.</p>
                    <a href="derecho-laboral/index.html" class="btn btn-primary" style="width:100%;">Saber más</a>
                </div>
            </div>
        </div>
    </section>
"@
    } else {
        # Individual Service
        $htmlBody = @"
    <section class="inner-hero">
        <div class="container">
            <h1 class="hero-title">$title</h1>
            <p class="hero-subtitle">Soluciones legales estratégicas</p>
        </div>
    </section>

    <section class="content-section">
        <div class="container grid-layout">
            <div class="main-text">
                <h2 style="font-size: 2.2rem; margin-bottom: 1.5rem; color: var(--color-primary);">Especialistas en $title</h2>
                <p style="font-size: 1.1rem; line-height: 1.8; color: var(--color-text-main); margin-bottom: 1.5rem;">
                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam in odio in est pellentesque hendrerit vel eu erat. 
                    Phasellus a sapien at justo iaculis eleifend. Duis ac tincidunt lectus, in luctus sapien.
                </p>
                <img src="https://images.unsplash.com/photo-1589829085413-56de8ae18c73?q=80&w=1000&auto=format&fit=crop" style="width:100%; border-radius: var(--radius-lg); margin-bottom: 2rem;" alt="$title">
                
                <h3 style="font-size: 1.8rem; margin-bottom: 1rem; color: var(--color-primary);">¿Cómo te ayudamos?</h3>
                <p style="font-size: 1.1rem; line-height: 1.8; color: var(--color-text-main); margin-bottom: 1.5rem;">
                    Suspendisse potenti. Etiam vel velit non neque facilisis aliquet. Vestibulum tristique sapien et nisi euismod, eget viverra tortor tristique. In hac habitasse platea dictumst.
                </p>
                
                <div class="grid-2-cols" style="gap: 2rem; margin: 2rem 0;">
                    <div style="background: var(--color-bg-light); padding: 1.5rem; border-radius: var(--radius-md);">
                        <i class="fas fa-check-circle" style="color: var(--color-accent); font-size: 1.5rem; margin-bottom: 1rem;"></i>
                        <h4>Consultoría Integral</h4>
                        <p style="font-size: 0.95rem; margin-top: 0.5rem; color: var(--color-text-muted);">Lorem ipsum dolor sit amet elit. Morbi tristique, sem quis tincidunt hendrerit.</p>
                    </div>
                    <div style="background: var(--color-bg-light); padding: 1.5rem; border-radius: var(--radius-md);">
                        <i class="fas fa-gavel" style="color: var(--color-accent); font-size: 1.5rem; margin-bottom: 1rem;"></i>
                        <h4>Representación Legal</h4>
                        <p style="font-size: 0.95rem; margin-top: 0.5rem; color: var(--color-text-muted);">Sed in risus ut lectus tempus ullamcorper. Vestibulum ut dolor id magna laoreet.</p>
                    </div>
                </div>
            </div>
            
            <aside class="sidebar text-center">
                <i class="fas $icon sidebar-icon"></i>
                <h3 style="margin-bottom: 1rem; color: var(--color-primary);">¿Necesitas asesoría?</h3>
                <p style="margin-bottom: 2rem; color: var(--color-text-muted);">Nuestro equipo está listo para resolver tu caso en $title. Contáctanos hoy.</p>
                <a href="${relativePath}contacto/index.html" class="btn btn-primary" style="width: 100%;">Agendar Consulta</a>
                
                <div style="margin-top: 2rem; padding-top: 2rem; border-top: 1px solid #e2e8f0;">
                    <h4 style="margin-bottom: 1rem;">Otros Servicios</h4>
                    <ul style="list-style: none; text-align: left; display: flex; flex-direction: column; gap: 0.8rem;">
                        <li><a href="${relativePath}servicios/propiedad-horizontal/index.html" style="color: var(--color-accent); font-weight: 500;"><i class="fas fa-angle-right"></i> Propiedad Horizontal</a></li>
                        <li><a href="${relativePath}servicios/urbanismo-e-inmobiliario/index.html" style="color: var(--color-accent); font-weight: 500;"><i class="fas fa-angle-right"></i> Urbanismo e Inmobiliario</a></li>
                        <li><a href="${relativePath}servicios/derecho-corporativo/index.html" style="color: var(--color-accent); font-weight: 500;"><i class="fas fa-angle-right"></i> Derecho Corporativo</a></li>
                    </ul>
                </div>
            </aside>
        </div>
    </section>
"@
    }

    $htmlFooter = @"
    <!-- FOOTER -->
    <footer class="main-footer dark-bg" style="padding: 2rem 0 0;">
        <div class="footer-bottom">
            <div class="container">
                <p>&copy; 2026 BCOM Abogados. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>
    
    <!-- WIDGETS -->
    <a href="https://wa.me/573108100727" class="whatsapp-float" target="_blank" rel="noopener">
        <i class="fab fa-whatsapp"></i>
    </a>
    <script src="${relativePath}main.js"></script>
</body>
</html>
"@

    $content = $htmlHead + $htmlHeader + $htmlBody + $htmlFooter
    $filePath = Join-Path $dir "index.html"
    Set-Content -Path $filePath -Value $content -Encoding UTF8
}
Write-Output "Diseños dinámicos generados exitosamente para todas las páginas."
