# Aim and Scope
Prepare per-sample CSV files with the from a SILVAngs project to be used as input for per-sample Krona charts, as used fro example by [MyOSD](http://my-osd.org/)

# Status
* The [first commit](7a5b1542470f5e55895ebf10e2eb50d445f294eb) of [split_fingerprint_by_sample.py](https://github.com/MicroB3-IS/osd-analysis/blob/master/perSampleKrona/split_fingerprint_by_sample.py):
  * is a very rough but working version
  * Uses the standard fingerprint CSV fiel as input
  * Removes taxonomic paths that are not present in the individual sample (data available in the fingerprint file)
  * Krona charts still need to be generated...
