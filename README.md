# docker-interproscan
**DO this before running docker**

https://github.com/ebi-pf-team/interproscan/wiki/HowToDownload

**1) Obtaining the core InterProScan software**
```
mkdir my_interproscan
cd my_interproscan
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.24-63.0/interproscan-5.24-63.0-64-bit.tar.gz
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.24-63.0/interproscan-5.24-63.0-64-bit.tar.gz.md5
```
Recommended checksum to confirm the download was successful:
```
md5sum -c interproscan-5.24-63.0-64-bit.tar.gz.md5
```
Must return *interproscan-5.24-63.0-64-bit.tar.gz: OK*
If not - try downloading the file again as it may be a corrupted copy.
```
tar -pxvzf interproscan-5.24-63.0-*-bit.tar.gz
```


**2) Installing Panther Models**
```
cd [InterProScan5 home]/data/
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-10.0.tar.gz
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-10.0.tar.gz.md5
md5sum -c panther-data-10.0.tar.gz.md5
```
This must return *panther-data-10.0.tar.gz: OK*
If not - try downloading the file again as it may be a corrupted copy.
```
cd [InterProScan5 home]/data
tar -pxvzf panther-data-10.0.tar.gz
```

**3) Using the Pre-calculated Match Lookup Service**

Create and enter a suitable directory
```
mkdir i5_lookup_service
cd i5_lookup_service
```
Download the tarball and the MD5 file.
```
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/lookup_service/lookup_service_5.24-63.0.tar.gz
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/lookup_service/lookup_service_5.24-63.0.tar.gz.md5
```
Recommended checksum to confirm the download was successful:
```
md5sum -c lookup_service_5.24-63.0.tar.gz.md5
```
Must return *lookup_service_5.24-63.0.tar.gz: OK*
If not - try downloading the file again as it may be a corrupted copy.
```
tar -pxvzf lookup_service_5.24-63.0.tar.gz
```
test if this command works
```
java -Xmx2000m -jar server-5.24-63.0-jetty-console.war --sslProxied --port 8000 --forwarded --headless
```
**RUN**
```
docker run --rm \
-v YOUR-PATH/my_interproscan:/interproscan/ \
-v YOUR-PATH/i5_lookup_service:/interproscan/i5_lookup_service/ \
-v YOUR-DATA-PATH:/mydata \
-v YOUR-TMP-PATH:/mytmp \
-w /interproscan/interproscan-5.24-63.0 \
-it interproscan:5.24-63.0
```
**TEST**
```
./interproscan.sh -i test_proteins.fasta -d /mydata -T /mytmp -dp
./interproscan.sh -i test_proteins.fasta -d /mydata -T /mytmp -pa -goterms
```
Check also https://hub.docker.com/r/tabotaab/interproscan/
