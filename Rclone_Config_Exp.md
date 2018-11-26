예시에서 사용된 Rclone Version은 아래와 같다

```
~$ rclone -V
rclone v1.44
- os/arch: linux/amd64
- go version: go1.11.1
```

###### 1. **Rclone Config** 

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
    - 이 때 'https://drive.google.com/drive/u/0/folders/\<Token\>'형태로 변경되는데 이 중 Token만 복사하여 붙여넣기
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
