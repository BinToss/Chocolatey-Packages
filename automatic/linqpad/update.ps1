import-module au

function global:au_SearchReplace {
    @{
        'linqpad.nuspec' = @{
            '(^\s*<dependency id="linqpad6" version=")(\[.*\])(" />)' = "`$1[$($Latest.Version)]`$3"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.linqpad.net/Download.aspx'

    $re = '<td[^>]*>\s*(?:<[^>]+>)*(6\.(?:\d+\.?)+)</'

    $versionMatches = $download_page | select-string -Pattern $re
    $versionMatch = $versionMatches.Matches[0]
    $version = $versionMatch.Groups[1].Value

    $Latest = @{ Version = $version }
    return $Latest
}

update
