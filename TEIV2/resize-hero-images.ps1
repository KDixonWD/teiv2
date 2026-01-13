param([switch]$Force)

$imagePath = "src\assets\hero-carousel"
$magickPath = "C:\Program Files\ImageMagick-7.1.2-Q16-HDRI\magick.exe"
$slides = @("slide1.jpg", "slide2.jpg", "slide3.jpg")
$sizes = @(
    @{w=2560; h=1440; suffix="2560w"},
    @{w=1920; h=1080; suffix="1920w"},
    @{w=1280; h=720; suffix="1280w"},
    @{w=1024; h=576; suffix="1024w"},
    @{w=768; h=432; suffix="768w"},
    @{w=640; h=360; suffix="640w"}
)

Write-Host "Resizing images..." -ForegroundColor Green

foreach ($slide in $slides) {
    $inputFile = Join-Path $imagePath $slide
    $baseName = $slide -replace '\.jpg$', ''
    
    if (!(Test-Path $inputFile)) {
        Write-Host "ERROR: $inputFile not found!"
        continue
    }
    
    Write-Host "Processing $slide..."
    
    foreach ($size in $sizes) {
        $outputFile = Join-Path $imagePath "$baseName-$($size.suffix).jpg"
        $cmd = @("$inputFile", "-resize", "$($size.w)x$($size.h)^", "-gravity", "Center", "-extent", "$($size.w)x$($size.h)", "-quality", "80", "$outputFile")
        
        Write-Host "  Creating: $baseName-$($size.suffix).jpg"
        & $magickPath $cmd
    }
}

Write-Host "Done!" -ForegroundColor Green
