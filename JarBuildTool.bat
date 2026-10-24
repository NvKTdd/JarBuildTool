::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJgZksaHErTXA==
::ZQ05rAF9IBncCkqN+0xwdVsEAlTMbiXqZg==
::ZQ05rAF9IAHYFVzEqQIaKQl2WQ2OOF+1Cbl8
::eg0/rx1wNQPfEVWB+kM9LVsJDC6DLkmvD7kY3Of046SFo1l9
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQIEIBJHDBSQM2G/BaFc4O33//nHu0IIFPMqcYzQ1q3OIvUa5kGkdNYH90gansIACVcYaRu/Zk86pi5DsmCMI86TvQ7tClqM9145CWB5gm3En2Vb
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE2lQbHB9QLA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRmF40NQ
::Zh4grVQjdCqDJH2N50kMZh9bWwqOM2q+Op8d+sru5uaDlkISWKw6YIq7
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983

@echo off
chcp 936 >nul
setlocal EnableExtensions
title Universal Gradle Build Tool

rem ==========================================
rem Universal Gradle Build Tool
rem License: EPL-2.0
rem ==========================================
rem
rem Copyright (c) 2026 NvKTdd and others.
rem 
rem This program and the accompanying materials are made available under the
rem terms of the Eclipse Public License 2.0 which is available at
rem http://www.eclipse.org/legal/epl-2.0.
rem
rem SPDX-License-Identifier: EPL-2.0


set "ORIGINAL_PATH=%PATH%"
set "ORIGINAL_JAVA_HOME=%JAVA_HOME%"
set "CUSTOM_JDK="
set "PROJECT="
set "LANGUAGE=EN"

:language
cls
echo ==========================================
echo      Universal Gradle Build Tool
echo ==========================================
echo.
echo   1. English
echo   2. Simplified Chinese
echo   0. Exit
echo.
set "CHOICE="
set /p "CHOICE=Language / 语言: "

if "%CHOICE%"=="1" set "LANGUAGE=EN"&goto input_path
if "%CHOICE%"=="2" set "LANGUAGE=CN"&goto input_path
if "%CHOICE%"=="0" goto finish
goto language

:input_path
cls
if "%LANGUAGE%"=="EN" (
    echo Enter project root directory.
    echo Leave blank to use this script's directory.
) else (
    echo 请输入项目根目录。
    echo 直接回车则使用脚本所在目录。
)
echo.

set "PROJECT="
set /p "PROJECT=Project path / 项目路径: "
if not defined PROJECT set "PROJECT=%~dp0"
set "PROJECT=%PROJECT:"=%"

if not exist "%PROJECT%\" (
    if "%LANGUAGE%"=="EN" (
        echo [ERROR] Directory does not exist.
    ) else (
        echo [错误] 目录不存在。
    )
    pause
    goto input_path
)

cd /d "%PROJECT%" 2>nul
if errorlevel 1 (
    echo [ERROR] Cannot access directory.
    pause
    goto input_path
)

if not exist "gradlew.bat" (
    if "%LANGUAGE%"=="EN" (
        echo [ERROR] gradlew.bat not found.
        echo Select the project root directory.
    ) else (
        echo [错误] 找不到 gradlew.bat。
        echo 请选择包含它的项目根目录。
    )
    pause
    goto input_path
)

:menu
cls
echo ==========================================
echo      Universal Gradle Build Tool
echo ==========================================
echo.
echo Project: %CD%
if defined CUSTOM_JDK (
    echo JDK: %CUSTOM_JDK%
) else (
    echo JDK: System default
)
echo.

if "%LANGUAGE%"=="EN" (
    echo   1. Build project
    echo   2. Clean and build
    echo   3. List Gradle tasks
    echo   4. Custom Gradle task
    echo   5. Change project directory
    echo   6. Configure JDK
    echo   7. Restore system Java
    echo   8. Show generated JAR files
    echo   0. Exit
) else (
    echo   1. 构建项目
    echo   2. 清理并构建
    echo   3. 查看 Gradle 任务
    echo   4. 自定义构建任务
    echo   5. 更换项目目录
    echo   6. 设置 JDK
    echo   7. 恢复系统 Java
    echo   8. 查找生成的 JAR
    echo   0. 退出
)
echo.

set "CHOICE="
set /p "CHOICE=Select / 选择: "

if "%CHOICE%"=="1" (
    call :run_task build
    goto menu
)
if "%CHOICE%"=="2" (
    call :run_task clean build
    goto menu
)
if "%CHOICE%"=="3" (
    call :run_task tasks
    goto menu
)
if "%CHOICE%"=="4" goto custom_task
if "%CHOICE%"=="5" goto input_path
if "%CHOICE%"=="6" goto set_jdk
if "%CHOICE%"=="7" (
    set "CUSTOM_JDK="
    if "%LANGUAGE%"=="EN" (
        echo System Java restored.
    ) else (
        echo 已恢复系统默认 Java。
    )
    pause
    goto menu
)
if "%CHOICE%"=="8" goto list_jars
if "%CHOICE%"=="0" goto finish

if "%LANGUAGE%"=="EN" (
    echo Invalid option.
) else (
    echo 无效选项。
)
pause
goto menu

:set_jdk
cls
echo.
if "%LANGUAGE%"=="EN" (
    echo Enter a JDK directory or the full path to java.exe.
    echo Example: C:\Program Files\Java\jdk-21
) else (
    echo 输入 JDK 根目录或 java.exe 的完整路径。
    echo 例如：C:\Program Files\Java\jdk-21
)
echo.

set "JDK_INPUT="
set /p "JDK_INPUT=JDK path / JDK路径: "
if not defined JDK_INPUT goto menu
set "JDK_INPUT=%JDK_INPUT:"=%"

if /i "%JDK_INPUT:~-8%"=="java.exe" (
    for %%I in ("%JDK_INPUT%") do set "JDK_BIN=%%~dpI"
    for %%I in ("%JDK_BIN%..") do set "JDK_HOME=%%~fI"
) else (
    set "JDK_HOME=%JDK_INPUT%"
)

if not exist "%JDK_HOME%\bin\java.exe" (
    if "%LANGUAGE%"=="EN" (
        echo [ERROR] java.exe not found in this JDK.
    ) else (
        echo [错误] 此路径下找不到 bin\java.exe。
    )
    pause
    goto menu
)

"%JDK_HOME%\bin\java.exe" -version
if errorlevel 1 (
    echo [ERROR] Java validation failed.
    pause
    goto menu
)

set "CUSTOM_JDK=%JDK_HOME%"
if "%LANGUAGE%"=="EN" (
    echo JDK configured successfully.
) else (
    echo JDK 设置成功。
)
pause
goto menu

:custom_task
cls
if "%LANGUAGE%"=="EN" (
    echo Enter a Gradle task, e.g. jar, assemble, clientJar.
) else (
    echo 输入 Gradle 任务名称，例如 jar、assemble、clientJar。
)
set "TASK="
set /p "TASK=Task / 任务: "
if not defined TASK goto menu

call :run_task %TASK%
goto menu

:run_task
cls
echo ==========================================
echo Project: %CD%
echo Task: %*
echo ==========================================
echo.

set "PATH=%ORIGINAL_PATH%"
set "JAVA_HOME=%ORIGINAL_JAVA_HOME%"

if defined CUSTOM_JDK (
    set "JAVA_HOME=%CUSTOM_JDK%"
    set "PATH=%CUSTOM_JDK%\bin;%ORIGINAL_PATH%"
)

java -version
if errorlevel 1 (
    echo [ERROR] Java is unavailable.
    pause
    exit /b
)

call gradlew.bat %*
set "RESULT=%ERRORLEVEL%"

echo.
if "%RESULT%"=="0" (
    if "%LANGUAGE%"=="EN" (
        echo [SUCCESS] Gradle task completed.
    ) else (
        echo [成功] Gradle 任务执行完成。
    )
) else (
    if "%LANGUAGE%"=="EN" (
        echo [FAILED] Gradle exit code: %RESULT%
    ) else (
        echo [失败] Gradle 退出代码：%RESULT%
    )
)

echo.
pause
exit /b

:list_jars
cls
if "%LANGUAGE%"=="EN" (
    echo Searching for JAR files in build directories...
) else (
    echo 正在查找 build 目录中的 JAR 文件...
)
echo.

if exist "build\" (
    for /r "build" %%F in (*.jar) do echo %%F
) else (
    if "%LANGUAGE%"=="EN" (
        echo No build directory found.
    ) else (
        echo 未找到 build 目录。
    )
)
echo.
pause
goto menu

:finish
endlocal
exit /b 0
