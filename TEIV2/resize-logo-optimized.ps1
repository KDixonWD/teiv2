param([switch]$Force)

$imagePath = "src\assets\global"
$magickPath = "C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe"
$logoFile = "TEI_logo.png"
$inputFile = Join-Path $imagePath $logoFile

# Logo aspect ratio is 799:312 (2.56:1)
# Use the ORIGINAL size - no resizing needed for crisp quality
# Astro will optimize and serve appropriately
$sizes = @(
    @{w=799; h=312; suffix="full"}
)

Write-Host "Resizing logo to optimized breakpoints..." -ForegroundColor Green
Write-Host "(Only 2 sizes: mobile 112px, desktop 180px)" -ForegroundColor Yellow

if (!(Test-Path $inputFile)) {
    Write-Host "ERROR: $inputFile not found!"
    exit 1
}

Write-Host "Processing $logoFile..."

foreach ($size in $sizes) {
    $outputFile = Join-Path $imagePath "$([System.IO.Path]::GetFileNameWithoutExtension($logoFile))-$($size.suffix).png"
    $cmd = @("$inputFile", "-resize", "$($size.w)x$($size.h)^", "-gravity", "Center", "-extent", "$($size.w)x$($size.h)", "$outputFile")
    
    Write-Host "  Creating: $(Split-Path $outputFile -Leaf)"
    & $magickPath $cmd
}

Write-Host ""
Write-Host "Done! Logo sizes created:" -ForegroundColor Green
Write-Host "  - TEI_logo-160w.png (mobile/tablet @2.8x)"
Write-Host "  - TEI_logo-280w.png (desktop @4.7x)" -ForegroundColor Yellow
