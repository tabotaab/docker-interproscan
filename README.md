# docker-interproscan
**Do these 3 steps before running docker**

[Interproscan reference](https://github.com/ebi-pf-team/interproscan/wiki/HowToDownload)

**1) Obtaining the core InterProScan software**

```
mkdir my_interproscan
cd my_interproscan
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.31-70.0/interproscan-5.31-70.0-64-bit.tar.gz
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/5.31-70.0/interproscan-5.31-70.0-64-bit.tar.gz.md5
```
Recommended checksum to confirm the download was successful:
```
md5sum -c interproscan-5.31-70.0-64-bit.tar.gz.md5
```
Must return *interproscan-5.31-70.0-64-bit.tar.gz: OK*
If not - try downloading the file again as it may be a corrupted copy.
```
tar -pxvzf interproscan-5.31-70.0-*-bit.tar.gz
```

**2) Installing Panther Models**

```
cd my_interproscan/interproscan-5.31-70.0/data/
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-12.0.tar.gz
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/data/panther-data-12.0.tar.gz.md5
md5sum -c panther-data-12.0.tar.gz.md5
```
This must return *panther-data-12.0.tar.gz: OK*
If not - try downloading the file again as it may be a corrupted copy.
```
cd my_interproscan/interproscan-5.31-70.0/data
tar -pxvzf panther-data-12.0.tar.gz
```

**3) Using the Pre-calculated Match Lookup Service**

Create and enter a suitable directory
```
mkdir my_interproscan/i5_lookup_service
cd my_interproscan/i5_lookup_service
```
Download the tarball and the MD5 file.
```
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/lookup_service/lookup_service_5.31-70.0.tar.gz
wget ftp://ftp.ebi.ac.uk/pub/software/unix/iprscan/5/lookup_service/lookup_service_5.31-70.0.tar.gz.md5
```
Recommended checksum to confirm the download was successful:
```
md5sum -c lookup_service_5.31-70.0.tar.gz.md5
```
Must return *lookup_service_5.31-70.0.tar.gz: OK*
If not - try downloading the file again as it may be a corrupted copy.
```
tar -pxvzf lookup_service_5.31-70.0.tar.gz
```
test if this command works
```
java -Xmx2000m -jar server-5.31-70.0-jetty-console.war --sslProxied --port 8000 --forwarded --headless
```

**RUN**

```
docker run --rm \
-v FULL-PATH/my_interproscan:/interproscan/ \
-v FULL-PATH/my_interproscan/i5_lookup_service:/interproscan/i5_lookup_service/ \
-v FULL-OUTDIR-PATH:/outdatadir \
-v FULL-TMP-PATH:/mytmp \
-w /interproscan/interproscan-5.31-70.0 \
-it interproscan:5.31-70.0
```

**TEST**

There is a test file already in "interproscan-5.31-70.0" folder called "test_proteins.fasta".
```
./interproscan.sh -i test_proteins.fasta -d /outdatadir -T /mytmp -dp
./interproscan.sh -i test_proteins.fasta -d /outdatadir -T /mytmp -pa -goterms
```

Check also https://hub.docker.com/r/tabotaab/docker-interproscan/
