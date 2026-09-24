const fs = require('fs');
const path = require('path');

const rootDir = __dirname;
const template = (title, depth) => {
    const relativePath = '../'.repeat(depth);
    return `<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} | BCOM Abogados</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${relativePath}styles.css">
</head>
<body>
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
        </div>
    </header>

    <section class="section-padding" style="margin-top: 100px; min-height: 50vh;">
        <div class="container">
            <h1 class="section-title">${title}</h1>
            <div class="title-divider"></div>
            <p style="font-size: 1.2rem; opacity: 0.8;">Página en construcción. Aquí irá el contenido de ${title}.</p>
        </div>
    </section>

    <!-- FOOTER -->
    <footer id="contacto" class="main-footer dark-bg">
        <div class="footer-bottom">
            <div class="container">
                <p>&copy; 2026 BCOM Abogados. Todos los derechos reservados.</p>
            </div>
        </div>
    </footer>
    <script src="${relativePath}main.js"></script>
</body>
</html>`;
};

const pages = [
    { path: 'nuestra-firma', title: 'Nuestra Firma', depth: 1 },
    { path: 'blog', title: 'Blog', depth: 1 },
    { path: 'contacto', title: 'Contacto', depth: 1 },
    { path: 'servicios', title: 'Servicios', depth: 1 },
    { path: 'servicios/propiedad-horizontal', title: 'Propiedad Horizontal', depth: 2 },
    { path: 'servicios/urbanismo-e-inmobiliario', title: 'Urbanismo e Inmobiliario', depth: 2 },
    { path: 'servicios/derecho-corporativo', title: 'Derecho Corporativo', depth: 2 },
    { path: 'servicios/derecho-civil', title: 'Derecho Civil', depth: 2 },
    { path: 'servicios/derecho-administrativo', title: 'Derecho Administrativo', depth: 2 },
    { path: 'servicios/derecho-laboral', title: 'Derecho Laboral', depth: 2 }
];

pages.forEach(p => {
    const dir = path.join(rootDir, p.path);
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
    }
    fs.writeFileSync(path.join(dir, 'index.html'), template(p.title, p.depth));
});
console.log('Created subpages successfully.');
