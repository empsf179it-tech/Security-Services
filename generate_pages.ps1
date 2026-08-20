$baseDir = "d:\Company websites\Professional Services\Security Services"
$pagesDir = Join-Path $baseDir "pages"

if (-not (Test-Path $pagesDir)) {
    New-Item -ItemType Directory -Force -Path $pagesDir
}

function Get-HtmlTemplate {
    param (
        [string]$Title,
        [string]$H1,
        [string]$H1Desc,
        [string]$H2,
        [string[]]$Items,
        [int]$Level
    )
    
    $prefix = if ($Level -eq 2) { "../" } else { "" }
    
    $itemsHtml = ""
    foreach ($item in $Items) {
        $itemsHtml += "                                <li><i class='fa-solid fa-check text-accent me-3'></i> $item</li>`n"
    }
    
    $html = @"
<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$Title | Shieldcore Security</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${prefix}assets/css/style.css">
</head>
<body>
    <!-- Header Placeholder -->
    <header class="main-header">
        <nav class="navbar custom-navbar">
            <div class="container-fluid px-4 px-lg-5">
                <a href="${prefix}index.html" class="navbar-brand">
                    <span class="logo-shield"><i class="fa-solid fa-shield-halved"></i></span>
                    <span class="logo-text">SHIELDCORE</span>
                </a>
                <div class="desktop-menu d-none d-lg-flex align-items-center">
                    <ul class="nav-links">
                        <li><a href="${prefix}index.html">Home</a></li>
                        <li><a href="${prefix}about.html">About</a></li>
                        <li><a href="${prefix}index.html#services">Services</a></li>
                        <li><a href="${prefix}contact.html">Contact</a></li>
                    </ul>
                    <div class="nav-actions ms-4">
                        <button id="theme-toggle" class="theme-btn me-3"><i class="fa-solid fa-sun"></i></button>
                        <a href="${prefix}contact.html" class="btn-premium btn-primary-premium">Request Assessment</a>
                    </div>
                </div>
            </div>
        </nav>
    </header>

    <main style="padding-top: 80px;">
        <!-- SECTION 01: Hero -->
        <section class="section-padding bg-primary-custom border-bottom" style="min-height: 50vh; display: flex; align-items: center;">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8">
                        <h5 class="text-accent mb-3">PREMIUM PROTECTION</h5>
                        <h1 class="display-4 fw-bold mb-4">$H1</h1>
                        <p class="lead text-secondary">$H1Desc</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- SECTION 02: Main Content -->
        <section class="section-padding bg-secondary-custom">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 mb-5 mb-lg-0">
                        <h2 class="display-6 fw-bold mb-4">$H2</h2>
                        <ul class="feature-list">
$itemsHtml
                        </ul>
                    </div>
                    <div class="col-lg-5 offset-lg-1">
                        <div class="img-box glow-container">
                            <img src="https://images.unsplash.com/photo-1557597774-9d273605dfa9?w=800&h=600&fit=crop" class="img-fluid rounded shadow-lg" alt="$Title">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer Placeholder -->
    <footer class="main-footer bg-secondary-custom section-padding pb-0 border-top">
        <div class="container">
            <div class="row g-4 mb-5">
                <div class="col-lg-4">
                    <a href="${prefix}index.html" class="footer-logo mb-4">
                        <i class="fa-solid fa-shield-halved"></i> SHIELDCORE
                    </a>
                    <p class="text-secondary">Advanced security solutions. 24/7 protection.</p>
                </div>
                <div class="col-lg-8 text-lg-end">
                    <a href="${prefix}contact.html" class="btn-premium btn-outline-premium">Contact Support</a>
                </div>
            </div>
            <div class="footer-bottom">
                <p class="mb-0 text-center text-muted">&copy; 2026 Shieldcore Security. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${prefix}assets/js/main.js"></script>
</body>
</html>
"@
    return $html
}

$pages = @(
    @{ path="about.html"; title="About Us"; h1="Built Around Trust and Protection."; h1Desc="Professionalism, vigilance, and technology driving rapid response."; h2="Our Security Philosophy"; items=@("Professionalism", "Vigilance", "Technology", "Responsibility", "Rapid response"); level=1 },
    @{ path="login.html"; title="Login"; h1="Client Portal Access"; h1Desc="Secure access to your dashboard and reports."; h2="Sign In"; items=@("View Incident Reports", "Manage Access Control", "Billing and Invoices", "24/7 Support Portal"); level=1 },
    @{ path="register.html"; title="Register"; h1="Partner With Us"; h1Desc="Create an account to request custom security assessments."; h2="Create Account"; items=@("Quick Registration", "Secure Data", "Custom Dashboard", "Priority Support"); level=1 },
    @{ path="contact.html"; title="Contact"; h1="Let's Build a Safer Environment."; h1Desc="Reach out to our security experts today."; h2="Get In Touch"; items=@("24/7 Command Center", "Free Security Assessment", "Rapid Deployment Team", "Consultation Services"); level=1 },
    @{ path="pages/it-company-security.html"; title="IT Company Security"; h1="Security Built for Modern Workplaces."; h1Desc="Protecting critical infrastructure, server rooms, and intellectual property."; h2="IT Company Security Solutions"; items=@("Reception security", "Visitor management", "Employee access control", "CCTV monitoring", "Server room protection", "Night security", "Emergency response", "Asset protection"); level=2 },
    @{ path="pages/apartment-security.html"; title="Apartment Security"; h1="A Safer Community Starts at the Gate."; h1Desc="Advanced visitor management, 24/7 patrol, and access control systems."; h2="Residential Solutions"; items=@("Gate security", "Visitor management", "Parking monitoring", "CCTV", "Resident verification", "Night patrol", "Emergency response"); level=2 },
    @{ path="pages/bank-security.html"; title="Bank Security"; h1="Protecting Every Transaction Starts With Protection."; h1Desc="High-threat environment protection with specialized personnel."; h2="Banking Solutions"; items=@("Branch security", "Entry monitoring", "CCTV", "Cash-area protection", "Access control", "Alarm response", "Customer safety", "Emergency protocols"); level=2 },
    @{ path="pages/mall-shopping-security.html"; title="Mall Security"; h1="Security for Every Crowd, Every Entrance, Every Hour."; h1Desc="Comprehensive security strategies for retail and shopping environments."; h2="Retail Solutions"; items=@("Entrance security", "Crowd management", "CCTV monitoring", "Retail theft prevention", "Parking security", "Emergency response", "Lost & found assistance", "Incident management"); level=2 },
    @{ path="pages/theatre-security.html"; title="Theatre Security"; h1="Keeping Every Show Safe From Opening to Closing."; h1Desc="Ensuring a safe and enjoyable experience for all patrons."; h2="Entertainment Solutions"; items=@("Entrance screening", "Crowd control", "Ticket-area monitoring", "Emergency response", "CCTV", "Exit monitoring", "Event security"); level=2 },
    @{ path="pages/hospital-security.html"; title="Hospital Security"; h1="Protecting Patients, Staff, and Every Critical Space."; h1Desc="Empathetic yet strict security protocols for healthcare environments."; h2="Healthcare Solutions"; items=@("Entrance security", "Emergency department security", "Visitor management", "Staff access", "Restricted-area protection", "CCTV monitoring", "Incident response"); level=2 },
    @{ path="pages/airport-terminal-security.html"; title="Airport Security"; h1="Security Across Every Gate, Terminal, and Passenger Journey."; h1Desc="Large-scale security operations for transit hubs."; h2="Transit Solutions"; items=@("Terminal security", "Entrance monitoring", "Crowd management", "Restricted-area access", "CCTV", "Emergency coordination", "Passenger-area security"); level=2 },
    @{ path="pages/corporate-security.html"; title="Corporate Security"; h1="Professional Protection for Professional Environments."; h1Desc="Executive protection and corporate asset security."; h2="Corporate Solutions"; items=@("Corporate reception", "Executive protection", "Visitor management", "Access control", "CCTV", "Security patrols", "Emergency response"); level=2 },
    @{ path="pages/event-security.html"; title="Event Security"; h1="When Thousands Gather, Security Must Be Ready."; h1Desc="Specialized crowd control and VIP protection for large events."; h2="Event Solutions"; items=@("Entry management", "Crowd control", "VIP protection", "Perimeter security", "Emergency response", "Event monitoring"); level=2 },
    @{ path="pages/surveillance-security.html"; title="Surveillance Security"; h1="See More. Respond Faster."; h1Desc="State-of-the-art CCTV and remote monitoring services."; h2="Monitoring Solutions"; items=@("CCTV monitoring", "Security control room", "Camera networks", "Incident monitoring", "Alerts", "Remote monitoring"); level=2 },
    @{ path="pages/access-control.html"; title="Access Control"; h1="Every Entry Should Be Controlled."; h1Desc="Advanced biometric and card-based access control systems."; h2="Access Solutions"; items=@("Access cards", "Biometric access", "Visitor management", "Restricted areas", "Entry logs", "Security verification"); level=2 },
    @{ path="pages/security-training.html"; title="Security Training"; h1="Trained People. Stronger Protection."; h1Desc="Industry-leading training programs for security personnel."; h2="Training Programs"; items=@("Guard training", "Emergency response", "Crowd management", "Communication", "Incident handling", "Professional conduct"); level=2 },
    @{ path="pages/retail-security.html"; title="Retail Security"; h1="Protecting Inventory and Personnel."; h1Desc="Loss prevention and secure shopping environments."; h2="Retail Solutions"; items=@("Loss prevention", "Storefront security", "CCTV", "Employee safety", "Inventory protection"); level=2 }
)

foreach ($page in $pages) {
    $fullPath = Join-Path $baseDir $page.path
    $htmlContent = Get-HtmlTemplate -Title $page.title -H1 $page.h1 -H1Desc $page.h1Desc -H2 $page.h2 -Items $page.items -Level $page.level
    Set-Content -Path $fullPath -Value $htmlContent -Encoding UTF8
    Write-Host "Generated $($page.path)"
}
