## WorkflowTemplate example
Argo allow us to create templates for workflows, then we can use these templates in many workflows or CronWorkflows again and again.
In this example, I created an WorkflowTemplate called `wf-template-condor-cpu-eff` which includes only one template of `condor-cpu-eff-test`. Naming is confusing, they also mention [this](https://argoproj.github.io/argo-workflows/workflow-templates/#workflowtemplate-vs-template).

We submit WorkflowTemplate with:</br >
`argo template create wf-template-condor-cpu-eff.yaml`

Now we can see our WorkflowTemplate in Argo UI.

Then we create a CronWorkflow using this template. CronWorkflow includes schedule time and steps. We can define DAGs, steps, scripts and so on in CronWorkflow and their specifications.
For example run steps sequentially or run them in paralel, or run different steps according to the result of previous stem. You can find more on in this [post](https://www.alibabacloud.com/help/doc-detail/119940.htm)

