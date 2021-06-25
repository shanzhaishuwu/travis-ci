# coding=utf-8

import boto3
import os
import datetime
import time

# 上传文件
def upload():
    s3 = boto3.resource('s3')
    for bucket in s3.buckets.all():
        if bucket.name == 'tapnow-dev':
            # 上传ipa文件
            try:
                file_name = os.path.join(os.getcwd(), 'TapNowScanner.ipa')
                bucket.upload_file(file_name, 'ios/TapNowScanner.ipa', ExtraArgs={'ACL': 'public-read'})
            except Exception as e:
                print('上传ipa到aws s3失败!')
                return False
            
            # 上传plist文件
            try:
                file_name = os.path.join(os.getcwd(), 'manifest.plist')
                bucket.upload_file(file_name, 'ios/manifest.plist', ExtraArgs={'ACL': 'public-read'})

            except:
                print('上传manifest到aws s3失败!')
                return False

    print('上传ipa、plist文件成功')
    return True


# 修改plist
def change_plist():
    return True

# 打包ipa
def package():
    try:
        cmd = 'export FASTLANE_XCODEBUILD_SETTINGS_TIMEOUT=120'
        os.system(cmd)

        today = time.strftime("%Y%m%d%H%M%S", time.localtime()) 
        cmd = 'fastlane beta_release buildnumber:' + today  + ' ipaname:travis-' + today + '.ipa' 
 
        os.system(cmd)
    except Exception as e:
        print('打包出错！！！！！！！！！')
        print('error = ' + str(e))
        return False
    
    return True

# 打包步骤
def process():
    # 打包
    try:
        cmd = 'chmod 777 scripts/add-key.sh'
        os.system(cmd)
        cmd = 'pod install'
        os.system(cmd)
        if package():
            # 打包成功，切换目录方便上传
            print('打包成功！')
            # path = os.path.join(os.getcwd(), 'fastlane/package')
            # os.chdir(path)

            # # 上传文件
            # upload()
        else:
            print('error')
    except Exception as e:
        print(e)


if __name__ == '__main__':
    process()