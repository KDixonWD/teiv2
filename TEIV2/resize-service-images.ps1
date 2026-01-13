param([switch]$Force)

$imagePath = "public\images\service-overview"
$outputPath = "src\assets\service-overview"
$magickPath = "C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe"
$images = @("Commercial.png", "Domestic.png", "Emeregency.png", "Ev.png", "Solar.png", "Testing.png")
$sizes = @(
    @{w=640; h=640; suffix="640w"},
    @{w=480; h=480; suffix="480w"},
    @{w=320; h=320; suffix="320w"}
)

# Create output directory if it doesn't exist
if (!(Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath | Out-Null
}

Write-Host "Resizing service overview images..." -ForegroundColor Green

foreach ($image in $images) {
    $inputFile = Join-Path $imagePath $image
    $baseName = $image -replace '\.(png|jpg)$', ''
    
    if (!(Test-Path $inputFile)) {
        Write-Host "ERROR: $inputFile not found!"
        continue
    }
    
    Write-Host "Processing $image..."
    
    foreach ($size in $sizes) {
        $outputFile = Join-Path $outputPath "$baseName-$($size.suffix).png"
        $cmd = @("$inputFile", "-resize", "$($size.w)x$($size.h)^", "-gravity", "Center", "-extent", "$($size.w)x$($size.h)", "$outputFile")
        
        Write-Host "  Creating: $baseName-$($size.suffix).png"
        & $magickPath $cmd
    }
    
    # Also copy original to assets folder
    $originalOutput = Join-Path $outputPath $image
    Copy-Item $inputFile $originalOutput -Force
    Write-Host "  Copied: $image"
}

Write-Host "Done!" -ForegroundColor Green
Write-Host "Images saved to: $outputPath" -ForegroundColor Yellow
