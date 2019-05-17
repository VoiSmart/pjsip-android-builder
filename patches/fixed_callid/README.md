# Fixed Call-ID patch

For our own purposes we are required to set the sip registration expiration to `2 weeks`. Moreover, our PBX identify different registrations based on the `Call-ID` header, which in PJSIP is randomly generated. 

Since the app gets closed/killed by the OS the new registration has a new Call-ID and so the registrations start to pile up. 

Using this patch we use the same Call-ID for every registration performed by the combination of same {fcm token, sipuser}. We have added another method to the pjsua2/swig binding to set the `Call-ID` from java code. If this value is not set, the library falls back to the regular way of generating the `Call-ID`.

The script also increases the `PJSIP_MAX_URL_SIZE` to `512` defined in `sip_config.g` because the FCM token may cause the Contact Header to exceed the max default size which was set to `256`.
