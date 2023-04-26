package com.fembuddy.gwc_doctor;

import android.app.Application;
import android.graphics.Color;
import android.util.Log;

import androidx.annotation.NonNull;

import com.bandyer.android_sdk.call.model.CallInfo;
import com.bandyer.android_sdk.call.notification.CallNotificationListener;
import com.bandyer.android_sdk.call.notification.CallNotificationStyle;
import com.bandyer.android_sdk.call.notification.CallNotificationType;
import com.bandyer.android_sdk.client.BandyerSDK;
import com.bandyer.android_sdk.client.BandyerSDKConfiguration;
import com.bandyer.android_sdk.intent.call.IncomingCall;
import com.bandyer.android_sdk.tool_configuration.call.SimpleCallConfiguration;
import com.bandyer.android_sdk.utils.BandyerSDKLoggerKt;
import com.bandyer.android_sdk.utils.provider.UserDetailsFormatter;
import com.bandyer.android_sdk.utils.provider.UserDetailsProvider;
import com.kaleyra.app_configuration.model.Configuration;
import com.kaleyra.app_utilities.storage.ConfigurationPrefsManager;
import com.kaleyra.collaboration_suite_networking.Environment;
import com.kaleyra.collaboration_suite_networking.Region;
import com.kaleyra.collaboration_suite_utils.logging.AndroidPriorityLoggerKt;
import com.kaleyra.collaboration_suite_utils.logging.BaseLogger;
import com.kaleyra.collaboration_suite_utils.logging.PriorityLogger;

public class App extends Application {

    @Override
    public void onCreate() {
        super.onCreate();
        /// sample
//        String apiKey = "ak_live_c1ef0ed161003e0a2b419d20";
//        String appId = "mAppId_002b0de9c8982a72afd4524b1b539313a7f044871c2e6225d691015cb8d9";
        /// production
        String apiKey = "ak_live_d2ad6702fe931fbeb2fa9cb4";
        String appId = "mAppId_a4908f3e2fa60c828daff5e875b0af422545696fa0bffa76d614489aae8d";

        Environment environment = Environment.Production.INSTANCE; // or Environment.Sandbox.INSTANCE

        Region region = Region.In.INSTANCE; // or Region.EU.INSTANCE
        Configuration appConfiguration = getAppConfiguration();


        if (appConfiguration.isMockConfiguration()) return;

        PriorityLogger logger = null;
        if (BuildConfig.DEBUG)
            logger = AndroidPriorityLoggerKt.androidPrioryLogger(BaseLogger.ERROR, BandyerSDKLoggerKt.SDK);
//
//        UserDetailsProvider userDetailsProvider = null;
//        if (appConfiguration.getUserDetailsProviderMode() != UserDetailsProviderMode.NONE) {
//            Log.d("appConfiguration:", appConfiguration.getUserDetailsProviderMode().toString());
//            userDetailsProvider = new MockedUserProvider(this);
//        }
//        BandyerSDK.getInstance().setUserDetailsProvider(userDetailsProvider);
//
//        UserDetailsFormatter userDetailsFormatter = (userDetails, context) -> {
//            UserDetailsProviderMode userDetailsProviderMode = appConfiguration.getUserDetailsProviderMode();
//            if (userDetailsProviderMode == UserDetailsProviderMode.NONE)
//                return userDetails.getUserAlias();
//            else if (userDetails.getNickName() != null && !userDetails.getNickName().isEmpty())
//                return userDetails.getNickName();
//            else return userDetails.getUserAlias();
//        };
//        BandyerSDK.getInstance().setUserDetailsFormatter(userDetailsFormatter);

        BandyerSDK.getInstance().configure(
                new BandyerSDKConfiguration.Builder(appId, environment, region)
                        .tools(builder -> {
                            builder.withCall(configurableCall -> {
                                configurableCall.setCallConfiguration(new SimpleCallConfiguration());
                            });
                        })
                        .notificationListeners(builder -> {
                            builder.setCallNotificationListener(getCallNotificationListener());
                        })
//                        .httpStack(Companion.getOkHttpClient())
                        .logger(logger)
                        .build()
        );


    }


    private CallNotificationListener getCallNotificationListener() {
        // custom notification listener
        return new CallNotificationListener() {

            @Override
            public void onIncomingCall(@NonNull IncomingCall incomingCall, boolean isDnd, boolean isScreenLocked) {
                if (!isDnd || isScreenLocked)
                    incomingCall
                            .show(App.this);
                else {
                    incomingCall
                            .asNotification()
                            .show(App.this);
                }
            }

            @Override
            public void onCreateNotification(@NonNull CallInfo callInfo,
                                             @NonNull CallNotificationType type,
                                             @NonNull CallNotificationStyle notificationStyle) {
                notificationStyle.setNotificationColor(Color.RED);
            }


        };
    }

    private Configuration getAppConfiguration() {
        return ConfigurationPrefsManager.INSTANCE.getConfiguration(this);
    }

}