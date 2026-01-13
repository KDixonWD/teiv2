param([switch]$Force)

$imagePath = "public\images\service-overview"
$outputPath = "src\assets\service-overview"
$magickPath = "C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe"
$images = @("Commercial.png", "Domestic.png", "Emeregency.png", "Ev.png", "Solar.png", "Testing.png")

# Only create 2 sizes: 300w (mobile) and 600w (desktop 2x)
$sizes = @(
    @{w=600; h=600; suffix="600w"},
    @{w=300; h=300; suffix="300w"}
)

# Create output directory if it doesn't exist
if (!(Test-Path $outputPath)) {
    New-Item -ItemType Directory -Path $outputPath | Out-Null
}

Write-Host "Resizing service overview images (2 sizes only)..." -ForegroundColor Green

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
    
    # Copy original
    $originalOutput = Join-Path $outputPath $image
    Copy-Item $inputFile $originalOutput -Force
    Write-Host "  Copied: $image"
}

Write-Host "Done!" -ForegroundColor Green
