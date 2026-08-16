az bicep publish -h

 Publish a bicep file.
        az bicep publish --file {bicep_file} --target "br:{registry}/{module_path}:{tag}"
        az bicep publish --file "./AppServicePlan.Bicep" --target "br:azbicepmodulesacr2.azurecr.io/bicep/appserviceplan:v1"

    Publish a bicep file overwriting an existing tag.
        az bicep publish --file {bicep_file} --target "br:{registry}/{module_path}:{tag} --force"

    Publish a bicep file with documentation uri.
        az bicep publish --file {bicep_file} --target "br:{registry}/{module_path}:{tag}"
        --documentation-uri {documentation_uri}

    Publish a bicep file with documentation uri and include source code
        az bicep publish --file {bicep_file} --target "br:{registry}/{module_path}:{tag}"
        --documentation-uri {documentation_uri} --with-source

