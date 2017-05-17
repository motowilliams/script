# Script Properties
Framework "4.5.2"
properties {
    $baseDirectory = Resolve-Path .\
    $sourceDirectory = "$baseDirectory\#_srcPath_#"

    $company = "#_companyName_#"
    $product = "#_productName_#"

    $outputDirectory = "$baseDirectory\#_artifactsPath_#"
    $packagesDirectory = "$sourceDirectory\packages"
    $packagesOutputDirectory = "$outputDirectory\packages"

    # msbuild settings
    $solution = "$companyNameClean.$productNameClean.sln"
    $solutionFile = "$sourceDirectory\$solution"
    $verbosity = "normal"
    $buildConfiguration = "Release"
    $buildPlatform = "Any CPU"
    $version = "1.0.0"
    $runOctoPack = "false"

    # tools
    $nugetExe = "$sourceDirectory\.nuget\nuget.exe"

    # database
    $databaseServer = "localhost\sqlexpress2016"
    $integratedSecurity = "Integrated Security=True"
}
