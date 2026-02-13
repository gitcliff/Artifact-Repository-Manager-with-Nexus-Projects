echo "Create a .sh file on the DigitalOcean droplet and ensure it has execute permissions"
echo "The .sh file should contain the following:"


# save the artifact details in a json file
curl -u {user}:{password} -X GET 'http://{nexus-ip}:8081/service/rest/v1/components?repository={repo-name}&sort=version' | jq "." > artifact.json

# grab the download url from the saved artifact details using 'jq' json processor tool
artifactDownloadUrl=$(jq -r '.items[].assets[].downloadUrl | select(endswith(".jar"))' artifact.json)

# fetch the artifact with the extracted download url using 'wget' tool
wget --http-user={user} --http-password={password} "$artifactDownloadUrl" -O java-app.jar

# Run the Java application
java -jar java-app.jar