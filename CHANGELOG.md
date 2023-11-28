# Change Log

## Version 2.7.0 (2022-11-22)

* Add patch to fix update_contact_header when need_outbound is false and only reg_contact_uri_params is not empty
* **Issues fixed**:
  * #54

## Version 2.6.0 (2022-11-22)

* Add patch to allow exporting of RtcpFb event data to pjsua2
* Add switch and setting to change the default PJSIP_TRANSPORT_IDLE_TIME
* **Issues fixed**:
  * #50
  * #51

## Version 2.5.0 (2022-11-03)

* Add switch to compile with debug symbols
* **Issues fixed**:
  * #49

## Version 2.4.1 (2022-07-29)

* Add switches to compile PJSIP with only specific support libraries

## Version 2.4.0 (2022-07-28)

* Bump default versions
  * NDK to `r21e`
  * PJSIP to `2.12.1`
  * Cmd Tools to `8512546`
* **Issues fixed**:
  * #48

## Version 2.3.0 (2021-05-19)

* Bump default versions
  * NDK to `r20b`
  * SWIG to `4.0.2`
  * PJSIP to `2.11`
  * OpenSSL to `1.1.1k`
  * OpenH264 to `2.1.0`
  * Opus to `1.3.1`
* Use bcg729 to enable `g729` codec
* **Issues fixed**:
  * #43
  * #44

## Version 2.2.0 (2020-03-30)

* Add flag to support IPv6
* **Issues fixed**:
  * #41

## Version 2.1.0 (2019-09-13)

* **Issues fixed**:
  * #31
  * #36
