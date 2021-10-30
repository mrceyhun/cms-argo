# cms-argo
Orchestrate workflows. Simplify cron jobs.

## what is Argo : "get stuff done with Kubernetes"
Argo is a workflow orchestration software like Airflow, Prefect, etc. It is a CNCF incubating project and written in Go. Argo ecosystem has great tools like ArgoCD, Argo Rollouts and Argo Events. For now, [Argo Workflows](https://argoproj.github.io/argo-workflows/) staisfy our needs. All workflow tasks in Argo are kubernetes containers and we define our workflows in yaml files like kubernetes manifests.

## why we use Argo
We want to manage our cron/acron jobs in one place and monitor them easily. Argo is light-weight, easy to install/manage, completely containarized tool.

###### what was challenging
- Spark cluster connection :rocket:
- EOS connection :rocket:

## install argo
`kubectl create ns argo`
`kubectl create rolebinding namespace-admin --clusterrole=admin --serviceaccount=default:default -n argo`
`kubectl apply -f install_argo.yaml -n argo`
**Argo UI URL**: [http://{K8S_NODE_NAME}.cern.ch:32746/](http://{K8S_NODE_NAME}.cern.ch:32746/)

### install argo cli
Reference:  https://github.com/argoproj/argo-workflows/releases/tag/v3.2.3

[P.S.] After this point, we assume argo cli is installed in the current directory as argo-linux-amd64.

### submit example workflow: condor-cpu-eff cron job
P.S. We use Argo [CronWorkflows|https://argoproj.github.io/argo-workflows/cron-workflows/] to schedule our workflow.

First of all, we need to define NodePorts for condor-cpu-eff, since these ports are required to connect Spark cluster.

`kubectl apply -f svc/condor_cpu_eff_svc.yaml`

Now we can submit our condor-cpu-eff cron workflow.

`./argo-linux-amd64 cron create cronwf/condor_cpu_eff_wf.yaml -n argo --strict=false`

#### check workflow with cli
Reference: https://argoproj.github.io/argo-workflows/quick-start/

`./argo-linux-amd64 list -n argo`
`./argo-linux-amd64 get -n argo @latest`
`./argo-linux-amd64 logs -n argo @latest`

### deletions

To delete a workflow with CLI: 
`./argo-linux-amd64 cron delete condor-cpu-eff-mz98l -n argo`

Delete Argo installation completely:
`kubectl delete -f install_argo.yaml -n argo`
`kubectl delete -f svc/condor_cpu_eff_svc.yaml`
`kubectl delete ns argo`

## References
- [Very detailed comparison of wf orchestration tools])[https://medium.com/arthur-engineering/picking-a-kubernetes-orchestrator-airflow-argo-and-prefect-83539ecc69b]
- [Quick start](https://argoproj.github.io/argo-workflows/quick-start/)
- [Installation example from AlibabaCloud](https://www.alibabacloud.com/blog/installing-argo-in-your-kubernetes-cluster_595446)
- [Cron workflows](https://argoproj.github.io/argo-workflows/cron-workflows/)
- [Cron Workflow example](https://github.com/argoproj/argo-workflows/blob/master/examples/cron-workflow.yaml)
- [RBAC](https://github.com/argoproj/argo-workflows/blob/master/docs/workflow-rbac.md)
- [Argo CLI](https://github.com/argoproj/argo-workflows/releases/tag/v3.2.3)
