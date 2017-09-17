workspace "cue"
    if _ACTION then
        location("build/".._ACTION)
    end

    configurations { "Debug", "Release", "Test" }

    architecture "x86_64"

    -- global workspace configurations
    filter "configurations:Debug"
        defines { "NLRS_DEBUG" }
        symbols "On"

    filter "configurations:Release"
        defines { "NDEBUG" }
        optimize "On"

    filter "configurations:Test"
        defines { "NLRS_DEBUG"}
        optimize "On"

    filter { "action:gmake or action:xcode*", "language:C++" }
        buildoptions { "-std=c++14" }

    filter "action:vs*"
        defines { "_CRT_SECURE_NO_WARNINGS" }

    group "extern"
--[[
                    
 _    _________ ___ 
| |/|/ / __/ -_) _ \
|__,__/_/  \__/_//_/
                    
--]]

    project "wren"
        language "C"
        kind "StaticLib"
        targetdir "lib"
        files { "extern/wren/src/vm/**.c", "extern/wren/src/optional/**.c" }
        includedirs { "extern/wren/src/vm", "extern/wren/src/optional", "extern/wren/src/include" }

--[[
                        __    __ 
 _    _________ ___  __/ /___/ /_
| |/|/ / __/ -_) _ \/_  __/_  __/
|__,__/_/  \__/_//_/ /_/   /_/   
                                 
--]]
    project "wren++"
        language "C++"
        kind "StaticLib"
        targetdir "lib"
        files { "extern/wrenpp/Wren++.cpp", "extern/wrenpp/Wren++.h" }
        includedirs { "extern/wren/src/include" }

    group "game"

    project "snake"
        kind "ConsoleApp"
        language "C++"
        targetdir "bin"
        debugdir "bin"
        files { "src/**.cpp", "src/**.h", "src/**.wren" }
        includedirs { "extern/CUE/include", "extern/SDL/include", "extern/wren/src/include", "extern/wrenpp/" }
        libdirs { "extern/CUE/lib/x64", "extern/SDL/bin/win64" }
        links { "CUESDK.x64_2013", "SDL2", "SDL2main", "wren", "wren++" }

        postbuildcommands {
            "{COPY} ../../extern/CUE/bin/x64/CUESDK.x64_2013.dll %{cfg.targetdir}",
            "{COPY} ../../extern/SDL/bin/win64/SDL2.dll %{ cfg.targetdir} "
        }

        filter "files:**.wren"
            buildcommands { "{COPY} %{file.relpath} %{cfg.targetdir}"}
            buildoutputs { "%{cfg.targetdir}/&{file.name}" }

