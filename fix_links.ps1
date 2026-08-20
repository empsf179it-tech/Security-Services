$filePath = "d:\Company websites\Professional Services\Security Services\index.html"
$content = Get-Content -Path $filePath -Raw

# Replace IDs for target sections
$content = $content -replace '<section class="hero-section">', '<section id="home" class="hero-section">'
$content = $content -replace '<section class="section-padding bg-primary-custom statistics-section">', '<section id="technology" class="section-padding bg-primary-custom statistics-section">'
$content = $content -replace '<section class="section-padding bg-secondary-custom process-section">', '<section id="process" class="section-padding bg-secondary-custom process-section">'
$content = $content -replace '<section class="section-padding bg-primary-custom relative-section">', '<section id="why-choose-us" class="section-padding bg-primary-custom relative-section">'
$content = $content -replace '<section class="cta-section', '<section id="cta" class="cta-section'
$content = $content -replace '<footer class="main-footer', '<footer id="contact" class="main-footer'

# Replace links
$content = $content -replace 'href="index.html"', 'href="#home"'
$content = $content -replace 'href="about.html"', 'href="#about"'
$content = $content -replace 'href="contact.html"', 'href="#contact"'

# Replace all pages/ links in the file
$content = $content -replace 'href="pages/(corporate-security|apartment-security|bank-security|retail-security|event-security|security-training|surveillance-security|access-control)\.html"', 'href="#services"'
$content = $content -replace 'href="pages/(it-company-security|hospital-security|airport-terminal-security|mall-shopping-security|theatre-security)\.html"', 'href="#industries"'

# Technology links
$content = $content -replace 'href="#">CCTV', 'href="#technology">CCTV'
$content = $content -replace 'href="#">Access Control', 'href="#technology">Access Control'
$content = $content -replace 'href="#">Visitor Management', 'href="#technology">Visitor Management'
$content = $content -replace 'href="#">Alarm Systems', 'href="#technology">Alarm Systems'

Set-Content -Path $filePath -Value $content -Encoding UTF8
