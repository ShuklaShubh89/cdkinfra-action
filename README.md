# ResumeWebsite Infra - CDK
A github action to manage the aws infrastructure by using aws cdk

For references about the available command options check [AWS CDK Toolkit (cdk)](https://docs.aws.amazon.com/cdk/latest/guide/tools.html)   
As you should be able to run any of the AWS CDK on this action
## Configuring credentials
The recommended way is to save your credentials as [secrets](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets) in your github repository  

Then just be sure you set the environment variables as follow:

```yaml
env:
  AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
  AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
  AWS_DEFAULT_REGION: 'us-east-1'
```
Check image versions available here: https://hub.docker.com/r/kikemnzz/automate-cdk-github-action-kmzz/tags?page=1&ordering=name
## Action Inputs:

| Action      | Description | Default     |
| :---        |    :----:   |          ---: |
| cdk_stack_directory      | stack location |   - |
| cdk_stack      | stack name |   - |
| cdk_action      | cdk command | -|
| cdk_version      | aws cdk version |   latest |


## Deploy All
Make sure the first step is building your application
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2      
      # Build your application here
      - run: echo 'Build and tests passed!'

      # Deploy stacks
      - name: cdk deploy all stacks
        uses: docker://ShuklaShubh89/automate-cdk-github-action-kmzz:v1.0.0
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'us-east-1'
        with:
          cdk_action: 'deploy --verbose --require-approval never'
```
In the example above by default this action will use the latest version of [aws-cdk](https://www.npmjs.com/package/aws-cdk) 

## Choose AWS CDK Version
In case a previous version of aws-cdk is required for your application set the aws cdk version you need  
```yaml
with:
  cdk_version: '1.31.0'
```

If all your stacks are using the same credentials you can set the environment variables at the job level
```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID_MyStack1 }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY_MyStack1 }}
      AWS_DEFAULT_REGION: 'us-east-1'
```
