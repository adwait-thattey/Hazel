workspace "Hazel"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"  -- use macros to build the path

project "Hazel"
	location "Hazel" -- relative path from root
	kind "SharedLib" -- for DLLs
	language "C++"

	targetdir	("bin/" .. outputdir .. "/%{prj.name}")
	objdir	("bin-int/" .. outputdir .. "/%{prj.name}") -- intermediate folder

	files
	{
		--[[
		Compile All .h and .cpp files inside src dir
		--]]

		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp" 

	}

	includedirs
	{
		"%{prj.name}/vendor/spdlog/include"
	}

	filter "system:windows"
		-- everything under here only for windows

		cppdialect "C++17"
		staticruntime "On" -- linking runtime libraries statically
		systemversion "latest" -- latest windows version

		defines
		{
			"HZ_PLATFORM_WINDOWS",
			"HZ_BUILD_DLL"
		}


		--postbuild step to copy binaries

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/Sandbox")
		}

	-- these are all independant filters. To use multiple filters, specify multiple
	filter "configurations:Debug"
		defines	"HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"

	-- multiple filters
	filter {"system:windows", "configurations:Release"}
		buildoptions "/MT"  -- enable multithread flag
	


project "Sandbox"
	location "Sandbox" -- relative path from root
	kind "ConsoleApp" -- for DLLs
	language "C++"

	targetdir	("bin/" .. outputdir .. "/%{prj.name}")
	objdir	("bin-int/" .. outputdir .. "/%{prj.name}") -- intermediate folder

	files
	{
		--[[
		Compile All .h and .cpp files inside src dir
		--]]

		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp" 

	}

	includedirs
	{
		"Hazel/vendor/spdlog/include",
		"Hazel/src"
	}

	links
	{
		"Hazel"
	}


	filter "system:windows"
		-- everything under here only for windows

		cppdialect "C++17"
		staticruntime "On" -- linking runtime libraries statically
		systemversion "latest" -- latest windows version

		defines
		{
			"HZ_PLATFORM_WINDOWS"
		}


		

	-- these are all independant filters. To use multiple filters, specify multiple
	filter "configurations:Debug"
		defines	"HZ_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HZ_DIST"
		optimize "On"

	-- multiple filters
	filter {"system:windows", "configurations:Release"}
		buildoptions "/MT"  -- enable multithread flag



	
