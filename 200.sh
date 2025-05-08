# Source: https://gist.github.com/637bb07e4338e03056c5e28cb47f56c1

#########################################################################
# cdk8s - Kubernetes Manifests With GoLang, TypeScript, Python And Java #
# https://youtu.be/F2DKtax0NLU                                          #
#########################################################################

# Additional Info:
# - cdk8s: https://cdk8s.io
# - Crossplane - GitOps-based Infrastructure as Code through Kubernetes API: https://youtu.be/n8KjVmuHm7A
# - How To Apply GitOps To Everything - Combining Argo CD And Crossplane: https://youtu.be/yrj4lmScKHQ
# - How To Shift Left Infrastructure Management Using Crossplane Compositions: https://youtu.be/AtbS1u2j7po
# - Cloud-Native Apps With Open Application Model (OAM) And KubeVela: https://youtu.be/2CBu6sOTtwk
# - Metacontroller - Custom Kubernetes Controllers The Easy Way: https://youtu.be/3xkLYOpXy2U
# - How GitHub Copilot And OpenAI Codex Help Developers Write Code: https://youtu.be/LEsPuLjwXn0
# - Kustomize - How to Simplify Kubernetes Configuration Management: https://youtu.be/Twtbg6LFnAg
# - Helm vs Kustomize - The Fight Between Templating and Patching in Kubernetes: https://youtu.be/ZMFYSm0ldQ0
# - Helm And Kustomize Replacement? Jsonnet With Grafana Tanka: https://youtu.be/-qpcsUXElYc
# - Carvel ytt Instead Of Helm? A Better Way To Manage Kubernetes Resources?: https://youtu.be/DLnXkH2keNg

#########
# Setup #
#########

git clone https://github.com/vfarcic/cdk8s-demo

cd cdk8s-demo

# Create a Kubernetes cluster

helm repo add crossplane-stable \
    https://charts.crossplane.io/stable

helm repo update

helm upgrade --install \
    crossplane crossplane-stable/crossplane \
    --namespace crossplane-system \
    --create-namespace \
    --wait

kubectl apply \
    --filename crossplane/provider-aws.yaml

kubectl apply \
    --filename crossplane/provider-sql.yaml

# Install the `cdk8s` CLI from https://cdk8s.io/docs/latest/getting-started/#install-the-cli

##########################################
# Create Kubernetes Manifests With cdk8s #
##########################################

cdk8s init go-app

cat main.go

cat app.go

cdk8s synth

cat dist/silly-demo.k8s.yaml

cdk8s import \
    github:crossplane/crossplane@1.9.1 \
    --language go

kubectl get crd \
    --output json \
    | cdk8s import /dev/stdin \
    --language go

cat get-crds.sh

./get-crds.sh

cdk8s import crds/crossplane.yaml \
    --language go

cat crossplane/aws.yaml

cat aws.go

cat sql.go

cat main.go

cat dist/aws.k8s.yaml

###########
# Destroy #
###########

# Destroy or reset the cluster.
