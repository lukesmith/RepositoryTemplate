@echo off
set FRAMEWORK_PATH=C:/WINDOWS/Microsoft.NET/Framework/v4.0.30319
set PATH=%PATH%;%FRAMEWORK_PATH%;
set TARGET_CONFIG=Release
SET SOLUTION_FILE=SampleSolution.sln
SET BUILD_DIR="%~dp0build\\"

IF EXIST %BUILD_DIR% (RD %BUILD_DIR% /S /Q)

IF "%build.number%"=="" (SET build.number=0.0.0.1)

echo using System.Reflection; > "src/VersionAssemblyInfo.generated.cs"
echo. >> "src/VersionAssemblyInfo.generated.cs"
echo [assembly: AssemblyVersion("%build.number%")] >> "src/VersionAssemblyInfo.generated.cs"
echo [assembly: AssemblyFileVersion("%build.number%")] >> "src/VersionAssemblyInfo.generated.cs"


echo.
echo === COMPILING ===
echo Compiling / Target: %FRAMEWORK_VERSION% / Config: %TARGET_CONFIG%

msbuild /nologo /verbosity:quiet %SOLUTION_FILE% /p:Configuration=%TARGET_CONFIG% /t:Clean
if errorlevel 1 goto failure

msbuild /nologo %SOLUTION_FILE% /p:Configuration=%TARGET_CONFIG%
if errorlevel 1 goto failure

goto complete

:failure
echo Failed to build
exit /b 1

:complete
exit /b o