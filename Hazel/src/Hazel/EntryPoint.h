#pragma once

#ifdef HZ_PLATFORM_WINDOWS

extern Hazel::Application* Hazel::CreateApplication();

int main(int argc, char** argv)
{
	Hazel::Log::Init();
	HZ_CORE_WARN("Initialized Log!");
	int a = 5;
	HZ_INFO("Hello! Var={0}", a);

	HZ_TRACE("Trace message");

	
	auto app = Hazel::CreateApplication();
	std::unique_ptr<Hazel::Application> ptrApp;
	ptrApp.reset(app);

	ptrApp->Run();
	
	//delete app;
}

#endif