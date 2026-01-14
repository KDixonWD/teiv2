param([switch]$Force)

$imagePath = "src\assets\global"
$magickPath = "C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe"
$logoFile = "TEI_logo.png"
$inputFile = Join-Path $imagePath $logoFile

# Generate Lighthouse-recommended size (225x88) + 2x retina
# Use original unresized logo as source for best quality
$sizes = @(
    @{w=225; h=88; suffix="225w"},
    @{w=450; h=176; suffix="450w"}
)

Write-Host "Resizing logo to Lighthouse recommended size..." -ForegroundColor Green

if (!(Test-Path $inputFile)) {
    Write-Host "ERROR: $inputFile not found!"
    exit 1
}

Write-Host "Processing $logoFile..."

foreach ($size in $sizes) {
    $outputFile = Join-Path $imagePath "$([System.IO.Path]::GetFileNameWithoutExtension($logoFile))-$($size.suffix).png"
    # Use -sample for pixel-perfect scaling with no filtering (best for logos)
    $cmd = @("$inputFile", "-sample", "$($size.w)x$($size.h)", "-quality", "100", "-define", "png:compression-level=9", "$outputFile")
    
    Write-Host "  Creating: $(Split-Path $outputFile -Leaf)"
    & $magickPath $cmd
}

Write-Host "Done! Logo sizes created:" -ForegroundColor Green
Write-Host "  - TEI_logo-225w.png (88px display 1x - Lighthouse recommended)"
Write-Host "  - TEI_logo-450w.png (88px display 2x retina)" -ForegroundColor Yellow


