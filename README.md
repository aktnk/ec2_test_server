# ec2_test_server
Using Terraform, set up a web server on AWS EC2, using nginx for the web server and php-fpm.

# how to use

##  prerequisites

* Running environment : ubuntu 20.04 LTS on wsl2 
* Docker has been installed.
* Executed terraform account configuration by aws configure command.
  ```
  $ aws configure --profile [terraform-account]
  ```
* The environment variable AWS_PROFILE in the .envrc file has been set to [terraform-account] configured above.
  ```
  export AWS_PROFILE=********
  ```

## usage

1. initialize
  * Start terraform container
    ```
    $ docker-compose up -d
    ```
  * Enter the terraform container
    ```
    $ docker-compose exec terraform ash
    ```
  * Initializing the terraform environment
    ```
    /workdir # terraform init
    ```
2. create and edit tf file

You should modify variables.tf according to the VPC configuration you wish to build.

Note:  
Access to this server is only allowed from the global IP address assigned to the environment in which terraform is run.

3. run terraform
  * Verify the description of the tf file in the local environment.
    ```
    /workdir # terraform validate
    ```
  * Check for changes.
    ```
    /workdir # terraform plan
    ```
  * Apply the changes and start up the test server.  
  When you are asked if you are sure you want to run it, type ``yes`` if you are sure.
    ```
    /wordkfir # terraform apply
    ```
  Note  
  When the execution of terraform apply is completed, the IP address and Public DNS name of the server started will be displayed as shown below.
  ```
    Enter a value: yes


  Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

  Outputs:

  ami_id = "ami-04d6e43069fd7e366"
  ec2_global_ips = [
    "*.*.*.*",
  ]
  ec2_public_dns_name = [
    "ec2-*-*-*-*.ap-northeast-1.compute.amazonaws.com",
  ]
  /workdir #
  ```

  If you use the ping command or browser access, you will see the following.
  ```
  > ping ec2-*-*-*-*.ap-northeast-1.compute.amazonaws.com

  ec2-*-*-*-*.ap-northeast-1.compute.amazonaws.com [*.*.*.*]に ping を送信しています 32 バイトのデータ:
  *.*.*.* からの応答: バイト数 =32 時間 =18ms TTL=227
  *.*.*.* からの応答: バイト数 =32 時間 =18ms TTL=227
  *.*.*.* からの応答: バイト数 =32 時間 =18ms TTL=227
  *.*.*.* からの応答: バイト数 =32 時間 =18ms TTL=227

  *.*.*.* の ping 統計:
      パケット数: 送信 = 4、受信 = 4、損失 = 0 (0% の損失)、
  ラウンド トリップの概算時間 (ミリ秒):
      最小 = 18ms、最大 = 18ms、平均 = 18ms
  >
  ```
  ![Example of display by browser](result.png)

4. terminate ec2 instance
  * Delete the test server.  
  You will be asked to confirm whether you want to execute it or not.
    ```
    /workdir # terraform destory
    ```

5. terminate terraform container
  * Exit terraform container.
    ```
    /workdir # exit
    ```
  * Stop terraform container.
    ```
    $ docker-compose stop
    ```
  Note  
  If you want to restart the terraform container, run `$ docker-compose start`.

# References

In constructing this environment, I referred to the following articles.

* [dockerhub : hashicorp/terraform](https://hub.docker.com/r/hashicorp/terraform)
* [github : terraform稼働開発環境](https://github.com/naritomo08/terraform_docker_public.git)
* [Terraform入門 : AWSのVPCとEC2を構築してみる](https://kacfg.com/terraform-vpc-ec2/)
* [Qiita : AmzonLinux2へのnginx + php-fpm + php7.2セットアップメモ](https://qiita.com/knymssh/items/15bb876da0688db5feb1)
