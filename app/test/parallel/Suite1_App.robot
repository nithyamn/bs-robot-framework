*** Settings ***
Library    AppiumLibrary
Library    Process  

*** Variables ***
${USERNAME}    %{BROWSERSTACK_USERNAME}    #Can specify BrowserStack Username directly instead of Environment variable.
${ACCESS_KEY}    %{BROWSERSTACK_ACCESS_KEY}    #Can specify BrowserStack Accesskey directly instead of Environment variable.
${REMOTE_URL}    http://${USERNAME}:${ACCESS_KEY}@hub-cloud.browserstack.com/wd/hub
${APP_PATH}    /Users/nithyamani/Desktop/APPS/WikipediaSample.apk

*** Test Cases ***
Appium Test on BrowserStack
    ${AppUrl}    Run Process    curl -u "${USERNAME}:${ACCESS_KEY}" -X POST "https://api-cloud.browserstack.com/app-automate/upload" -F "file\=@${APP_PATH}"    shell=true    alias=AppUpload       
    ${AppData}    Evaluate    json.loads("""${AppUrl.stdout}""")    json
    Log    ${AppUrl.stdout}
    ${hash_id}    Set Variable     ${AppData['app_url']}
    Log    ${hash_id}
    Open Application    ${REMOTE_URL}    app=${hash_id}    name=parallel_test    build=RobotFramework    platformName=Android    os_version=10.0    device=Google Pixel 4
	# id=org.wikipedia.alpha:id/search_container
	Click Element    id=org.wikipedia.alpha:id/search_container
	# id=org.wikipedia.alpha:id/search_src_text
	Click Element    id=org.wikipedia.alpha:id/search_src_text
	Input Text    id=org.wikipedia.alpha:id/search_src_text    BrowserStack
	Click Element    id=org.wikipedia.alpha:id/search_src_text
	# xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout[2]/android.view.ViewGroup/android.support.v4.view.ViewPager/android.view.ViewGroup/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.FrameLayout[1]/android.widget.LinearLayout
	Click Element    xpath=/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.LinearLayout[2]/android.view.ViewGroup/android.support.v4.view.ViewPager/android.view.ViewGroup/android.widget.FrameLayout/android.support.v7.widget.RecyclerView/android.widget.FrameLayout[1]/android.widget.LinearLayout
	Close Application

