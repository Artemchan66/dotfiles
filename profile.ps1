oh-my-posh init pwsh | Invoke-Expression

function touch { New-Item $args[0] -ItemType File -Force }
function mv { mv $args[0] $args[1] -Force -Recurse }
function cpwd { Set-Clipboard $PWD }
if (test-path alias:ls) {Remove-Item alias:ls -Force}
function ls { Get-ChildItem -Force @args }
if (test-path alias:sl) {Remove-Item alias:sl -Force} 

function yt {
    param(
        [Parameter(Mandatory, ValueFromRemainingArguments)]
        [string[]]$Args
    )
    yt-dlp -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" @Args
}

function fsize {
    param([string]$Path = ".")
    $bytes = (Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue |
        Measure-Object -Property Length -Sum).Sum
    if (-not $bytes) { $bytes = 0 }
    switch ($bytes) {
        {$_ -ge 1GB} { "{0:N2} GB" -f ($bytes/1GB); break }
        {$_ -ge 1MB} { "{0:N2} MB" -f ($bytes/1MB); break }
        {$_ -ge 1KB} { "{0:N2} KB" -f ($bytes/1KB); break }
        default { "$bytes bytes" }
    }
}