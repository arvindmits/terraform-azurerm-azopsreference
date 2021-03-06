# This file was auto generated
resource "azurerm_policy_definition" "deploy_diagnostics_databricks" {
  name         = "Deploy-Diagnostics-Databricks"
  policy_type  = "Custom"
  mode         = "All"
  display_name = "Deploy-Diagnostics-Databricks"
  description  = "Apply diagnostic settings for Databricks - Log Analytics"

  management_group_name = var.management_group_name
  policy_rule           = <<POLICYRULE
{
  "if": {
    "field": "type",
    "equals": "Microsoft.Databricks/workspaces"
  },
  "then": {
    "effect": "deployIfNotExists",
    "details": {
      "type": "Microsoft.Insights/diagnosticSettings",
      "name": "setByPolicy",
      "existenceCondition": {
        "allOf": [
          {
            "field": "Microsoft.Insights/diagnosticSettings/logs.enabled",
            "equals": "true"
          },
          {
            "field": "Microsoft.Insights/diagnosticSettings/metrics.enabled",
            "equals": "true"
          },
          {
            "field": "Microsoft.Insights/diagnosticSettings/workspaceId",
            "equals": "[parameters('logAnalytics')]"
          }
        ]
      },
      "roleDefinitionIds": [
        "/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c"
      ],
      "deployment": {
        "properties": {
          "mode": "incremental",
          "template": {
            "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
            "contentVersion": "1.0.0.0",
            "parameters": {
              "resourceName": {
                "type": "string"
              },
              "logAnalytics": {
                "type": "string"
              },
              "location": {
                "type": "string"
              }
            },
            "variables": {},
            "resources": [
              {
                "type": "Microsoft.Databricks/workspaces/providers/diagnosticSettings",
                "apiVersion": "2017-05-01-preview",
                "name": "[concat(parameters('resourceName'), '/', 'Microsoft.Insights/setByPolicy')]",
                "location": "[parameters('location')]",
                "dependsOn": [],
                "properties": {
                  "workspaceId": "[parameters('logAnalytics')]",
                  "metrics": [],
                  "logs": [
                    {
                      "category": "dbfs",
                      "enabled": true
                    },
                    {
                      "category": "clusters",
                      "enabled": true
                    },
                    {
                      "category": "accounts",
                      "enabled": true
                    },
                    {
                      "category": "jobs",
                      "enabled": true
                    },
                    {
                      "category": "notebook",
                      "enabled": true
                    },
                    {
                      "category": "ssh",
                      "enabled": true
                    },
                    {
                      "category": "workspace",
                      "enabled": true
                    },
                    {
                      "category": "secrets",
                      "enabled": true
                    },
                    {
                      "category": "sqlPermissions",
                      "enabled": true
                    },
                    {
                      "category": "instancePools",
                      "enabled": true
                    }
                  ]
                }
              }
            ],
            "outputs": {}
          },
          "parameters": {
            "logAnalytics": {
              "value": "[parameters('logAnalytics')]"
            },
            "location": {
              "value": "[field('location')]"
            },
            "resourceName": {
              "value": "[field('name')]"
            }
          }
        }
      }
    }
  }
}
POLICYRULE

  parameters = <<PARAMETERS
{
  "logAnalytics": {
    "type": "String",
    "metadata": {
      "displayName": "Log Analytics workspace",
      "description": "Select the Log Analytics workspace from dropdown list",
      "strongType": "omsWorkspace"
    }
  }
}
PARAMETERS

}

output "policydefinition_deploy_diagnostics_databricks" {
  value = azurerm_policy_definition.deploy_diagnostics_databricks
}

