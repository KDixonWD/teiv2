param([switch]$Force)

$imagePath = "src\assets\global"
$magickPath = "C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe"
$logoFile = "TEI_logo.png"
$inputFile = Join-Path $imagePath $logoFile

# Only create 2 sizes: 200px and 300px (150px will use 300px on retina)
$sizes = @(
    @{w=300; h=117; suffix="300w"},
    @{w=200; h=78; suffix="200w"},
    @{w=150; h=58; suffix="150w"}
)

Write-Host "Resizing logo to responsive sizes..." -ForegroundColor Green

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

Write-Host "Done! Logo sizes created:" -ForegroundColor Green
Write-Host "  - TEI_logo-150w.png (100px display on mobile)"
Write-Host "  - TEI_logo-200w.png (150px display 1x)" 
Write-Host "  - TEI_logo-300w.png (150px display 2x)" -ForegroundColor Yellow
