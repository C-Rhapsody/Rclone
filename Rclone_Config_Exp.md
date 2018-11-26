예시에서 사용된 Rclone Version은 아래와 같다

```
~$ rclone -V
rclone v1.44
- os/arch: linux/amd64
- go version: go1.11.1
```

##### 1. **Rclone Config** 

처음 실행하면 아래와 같이 아무런 구성이 없다.
```
~$ rclone config
Current remotes:

Name                 Type
====                 ====

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
```

'n'을 입력하여 자신이 사용할 Config의 이름을 정의한다.

예시에서는 'GoogleDrive'라 하였다.
```
e/n/d/r/c/s/q> n
name> GoogleDrive
```

'Config name'이 사용할 서비스를 정한다.

예시는 '12번 Google Drive'
```
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / A stackable unification remote, which can appear to merge the contents of several remotes
   \ "union"
 2 / Alias for a existing remote
   \ "alias"
 3 / Amazon Drive
   \ "amazon cloud drive"
 4 / Amazon S3 Compliant Storage Providers (AWS, Ceph, Dreamhost, IBM COS, Minio)
   \ "s3"
 5 / Backblaze B2
   \ "b2"
 6 / Box
   \ "box"
 7 / Cache a remote
   \ "cache"
 8 / Dropbox
   \ "dropbox"
 9 / Encrypt/Decrypt a remote
   \ "crypt"
10 / FTP Connection
   \ "ftp"
11 / Google Cloud Storage (this is not Google Drive)
   \ "google cloud storage"
12 / Google Drive
   \ "drive"
13 / Hubic
   \ "hubic"
14 / JottaCloud
   \ "jottacloud"
15 / Local Disk
   \ "local"
16 / Mega
   \ "mega"
17 / Microsoft Azure Blob Storage
   \ "azureblob"
18 / Microsoft OneDrive
   \ "onedrive"
19 / OpenDrive
   \ "opendrive"
20 / Openstack Swift (Rackspace Cloud Files, Memset Memstore, OVH)
   \ "swift"
21 / Pcloud
   \ "pcloud"
22 / QingCloud Object Storage
   \ "qingstor"
23 / SSH/SFTP Connection
   \ "sftp"
24 / Webdav
   \ "webdav"
25 / Yandex Disk
   \ "yandex"
26 / http Connection
   \ "http"
Storage> 12
```

구글드라이브에 접근할 때 사용할 Client_id와 Secret_Key를 입력한다.
  - plexdrive는 여기서 Google Developer 사이트에서 프로젝트 생성해 주고 이 키를 어딘가에 저장해야 하는데, rclone은 그럴 필요가 없이 저절로 갱신해 준다. **그냥 엔터를 눌러 넘어가기를 추천!!!!**
```
** See help for drive backend at: https://rclone.org/drive/ **

Google Application Client Id
Leave blank normally.
Enter a string value. Press Enter for the default ("").
client_id>
Google Application Client Secret
Leave blank normally.
Enter a string value. Press Enter for the default ("").
client_secret>
```

구글드라이브에 접근할 권한을 설정한다. 

예시에서는 plexmediaserver로만 사용할거라 '2번 read-only'로 설정
```
Scope that rclone should use when requesting access from drive.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / Full access all files, excluding Application Data Folder.
   \ "drive"
 2 / Read-only access to file metadata and file contents.
   \ "drive.readonly"
   / Access to files created by rclone only.
 3 | These are visible in the drive website.
   | File authorization is revoked when the user deauthorizes the app.
   \ "drive.file"
   / Allows read and write access to the Application Data folder.
 4 | This is not visible in the drive website.
   \ "drive.appfolder"
   / Allows read-only access to file metadata but
 5 | does not allow any access to read or download file content.
   \ "drive.metadata.readonly"
scope> 2
```

구글드라이브 내용중에 필요로 하는 폴더의 Token(?)키 값을 지정해 준다. 

  - 모든 디렉토리를 포함할 거라면 그냥 엔터
  - 특정 디렉토리만 포함하여 root로 사용하고 싶다면 웹으로 구글드라이브에 접속한 다음에, 사용하고 싶은 특정 디렉토리에 접속하면 상단의 URL이 변경된다.
    - 이 때 'https://drive.google.com/drive/u/0/folders/ \<Token\>'형태로 변경되는데 이 중 Token만 복사하여 붙여넣기
```
ID of the root folder
Leave blank normally.
Fill in to access "Computers" folders. (see docs).
Enter a string value. Press Enter for the default ("").
root_folder_id>
```

이후 설정은 접속권한을 설정하는 것 같으나 잘 모르겠음. 그냥 엔터
```
Service Account Credentials JSON file path
Leave blank normally.
Needed only if you want use SA instead of interactive login.
Enter a string value. Press Enter for the default ("").
service_account_file>
```

고급설정. 그냥 'n' 엔터 -_-;
```
Edit advanced config? (y/n)
y) Yes
n) No
y/n> n
```

이후 Rclone을 사용할 시스템이 ssh를 통하지 않고 직접 키보드/마우스를 입력하여 모니터로 화면을 보고 있다면 'y'를 입력, 

(이러면 기본브라우저로 바로 링크가 열린다)

ssh나 telnet을 통해서 구성중이라면(Headless) 'n'을 입력한다.

예시에서는 'n'
```
Remote config
Use auto config?
 * Say Y if not sure
 * Say N if you are working on a remote or headless machine or Y didn't work
y) Yes
n) No
y/n> n
```

'n'을 통해서 remote config로 Oauth URL을 알려준다. 이 링크를 복사하여 브라우저를 통해서 접속
```
If your browser doesn't open automatically go to the following link: https://accounts.google.com/o/oauth2/auth?access_type=offline&client_id=<블라블라>.apps.googleusercontent.com&redirect_uri=urn%<블라블라>
Log in and authorize rclone for access
```

이후 자신의 Google 계정으로 접근하여, 접근을 허용해 주면 Oauth Secret Token을 얻을 수 있다. 이 토큰을 복사한 뒤 붙여 넣어 준다.x
```
Enter verification code> <복사한 Token>
```

팀드라이브 연결할 것인가 묻는다. 이는 따로 가입한 팀드라이브가 없어서 테스트해보지 못한다.

예시에서는 'n'을 입력하여 Pass
```
Configure this as a team drive?
y) Yes
n) No
y/n> n
```

모든 구성 확인! 여기까지 잘 따라왔다면 뒤도 돌아보지 말고 'y'를 눌러 저장한다.
```
--------------------
[GoogleDrive]
type = drive
scope = drive.readonly
token = {"access_token":"<블라블라>","token_type":"Bearer","refresh_token":"<블라블라>","expiry":"<갱신종료 정보>"}
--------------------
y) Yes this is OK
e) Edit this remote
d) Delete this remote
y/e/d> y
```

이후 만들어진 Config Name을 잘 기억하도록 하자!!!
```
Current remotes:

Name                 Type
====                 ====
GoogleDrive          drive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q>
```

##### **2. Cache 설정**

1번과 동일하게 rclone config 화면으로 이동한다.

(1번항 완료 후 바로 실행하면 PASS)
```
~$ rclone config
Current remotes:

Name                 Type
====                 ====
GoogleDrive          drive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q>
```

'n'을 입력하여 새로운 Config Name을 지정해 준다.

예시에서는 'cache'
```
e/n/d/r/c/s/q> n
name> cache
```

이제 Type을 결정하는데, 이 때 '7번. Cache a remote'를 입력하여 준다.
```
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value
 1 / A stackable unification remote, which can appear to merge the contents of several remotes
   \ "union"
 2 / Alias for a existing remote
   \ "alias"
 3 / Amazon Drive
   \ "amazon cloud drive"
 4 / Amazon S3 Compliant Storage Providers (AWS, Ceph, Dreamhost, IBM COS, Minio)
   \ "s3"
 5 / Backblaze B2
   \ "b2"
 6 / Box
   \ "box"
 7 / Cache a remote
   \ "cache"
 8 / Dropbox
   \ "dropbox"
 9 / Encrypt/Decrypt a remote
   \ "crypt"
10 / FTP Connection
   \ "ftp"
11 / Google Cloud Storage (this is not Google Drive)
   \ "google cloud storage"
12 / Google Drive
   \ "drive"
13 / Hubic
   \ "hubic"
14 / JottaCloud
   \ "jottacloud"
15 / Local Disk
   \ "local"
16 / Mega
   \ "mega"
17 / Microsoft Azure Blob Storage
   \ "azureblob"
18 / Microsoft OneDrive
   \ "onedrive"
19 / OpenDrive
   \ "opendrive"
20 / Openstack Swift (Rackspace Cloud Files, Memset Memstore, OVH)
   \ "swift"
21 / Pcloud
   \ "pcloud"
22 / QingCloud Object Storage
   \ "qingstor"
23 / SSH/SFTP Connection
   \ "sftp"
24 / Webdav
   \ "webdav"
25 / Yandex Disk
   \ "yandex"
26 / http Connection
   \ "http"
Storage> 7
```

이후 caching 할 rclone config name과 디렉토리를 결정해 준다.

예시에서는 'GoogleDrive:' <- 뒤에 ':' 꼭 입력!
```
** See help for cache backend at: https://rclone.org/cache/ **

Remote to cache.
Normally should contain a ':' and a path, eg "myremote:path/to/dir",
"myremote:bucket" or maybe "myremote:" (not recommended).
Enter a string value. Press Enter for the default ("").
remote> GoogleDrive:
```

plexmediaserver를 위한 cache 기능이므로, plex에 관련된 정보를 입력한다.(같은 컴퓨터에서만 동작할 것이다.)

만약 plexmediaserver가 설치되어 있지 않다면 대충 엔터 (나중에 설정을 변경할 수 있음)

예시에서는 'http://127.0.0.1:32400'
```
The URL of the Plex server
Enter a string value. Press Enter for the default ("").
plex_url> http://127.0.0.1:32400
```

plex id를 입력한다.(이메일 계정으로는 시도해 보지 못하였다)
```
The username of the Plex user
Enter a string value. Press Enter for the default ("").
plex_username> Cat'sRhapsody
```

plex 비밀번호를 설정한다. 비번은 크게 관련이 없는것인지 패스워드를 임의로 결정하는 메뉴가 있는데, 테스트는 따로 하지 않았다.

예시에서는 실제 비밀번호를 입력할 것임으로 'y'입력
```
The password of the Plex user
y) Yes type in my own password
g) Generate random password
n) No leave this optional password blank
y/g/n> y
```

비밀번호를 입력한다.
```
Enter the password:
Confirm the password:
```

cache에 사용될 chunk 사이지를 결정한다. (직접 입력 가능)

예시에서는 기본값인 '5M'선택

```
The size of a chunk (partial file data).

Use lower numbers for slower connections. If the chunk size is
changed, any downloaded chunks will be invalid and cache-chunk-path
will need to be cleared or unexpected EOF errors will occur.
Enter a size with suffix k,M,G,T. Press Enter for the default ("5M").
Choose a number from below, or type in your own value
 1 / 1MB
   \ "1m"
 2 / 5 MB
   \ "5M"
 3 / 10 MB
   \ "10M"
chunk_size> 2
```

cache chunk가 유지될 시간을 정해준다.

예시에서는 기본값인 '6h'를 직접 입력
```
How long to cache file structure information (directory listings, file size, times etc).
If all write operations are done through the cache then you can safely make
this value very large as the cache store will also be updated in real time.
Enter a duration s,m,h,d,w,M,y. Press Enter for the default ("6h0m0s").
Choose a number from below, or type in your own value
 1 / 1 hour
   \ "1h"
 2 / 24 hours
   \ "24h"
 3 / 48 hours
   \ "48h"
info_age> 6h
```

Chunk의 Total Size를 입력한다.

예시에서는 기본값인 '10G'를 선택
```
If the cache exceeds this value then it will start to delete the
oldest chunks until it goes under this value.
Enter a size with suffix k,M,G,T. Press Enter for the default ("10G").
Choose a number from below, or type in your own value
 1 / 500 MB
   \ "500M"
 2 / 1 GB
   \ "1G"
 3 / 10 GB
   \ "10G"
chunk_total_size> 3
```

고급설정 메뉴 입력 유무를 입력한다.

예시에서는 'n'을 입력하여 모두 기본값으로 설정('/home/<username>/.config/rclone', etc....)

```
Edit advanced config? (y/n)
y) Yes
n) No
y/n> n
```
 
최종 설정 확인, 위 절차를 모두 잘 따라왔다면 크게 무리 없을 것임으로 'y'를 입력하여 설정을 마친다.
```
Remote config
--------------------
[cache]
type = cache
remote = GoogleDrive:
plex_password = *** ENCRYPTED ***
chunk_size = 5M
info_age = 6h0m0s
chunk_total_size = 10G
--------------------
y) Yes this is OK
e) Edit this remote
d) Delete this remote
y/e/d> y
```

예시대로 한다면 최종적으로는 아래와 같이 설정되있어야 한다. (기존 Config Name제외)

모두 설정이 잘 되어 있다면 'q'를 입력하여 rclone config를 종료한다.

```
Current remotes:

Name                 Type
====                 ====
GoogleDrive          drive
cache                cache

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q
```


##### **3. Rclone Mount**

여기서 조심해야 할 것은 Rclone Config에서 지정한 Name을 통해서 Mount를 해야 하는데, 이 때 구글드라이브를 구성한 Name(예시에서는 GoogleDrive)을 Mount하는 것이 아니라, Cache를 구성한 Name(예시에서는 cache)를 마운트해야 한다.

이를 스크립트로 작성하여 Cron 또는 Service로 등록하고, plexmediaserver에서 라이브러리로 구성할 디렉토리에 포함시켜 스캔한다.

예시는 아래와 같다. (Cron)
```
#!/bin/bash
#
# Environment 
# OS : Ubuntu 18.04 LTS
# Rclone Ver : v1.44
#
# Cron Use Exp
#   */5 * * * * /bin/bash /<path>/MountRclone.sh

MountDir = "/home/<username>/rclone/cache/"
RcloneConf = "/home/<username>/.config/rclone/rclone.conf"

if [ ! -d "$MountDir/Temp" ]; then
    rclone mount cache: "$MountDir" \
    --config "RcloneConf" \
    --allow-non-empty --allow-other --read-only \
    --uid <current_uid> --gid <current_gid> &
else
    echo "Pre Mounting"
fi
```

