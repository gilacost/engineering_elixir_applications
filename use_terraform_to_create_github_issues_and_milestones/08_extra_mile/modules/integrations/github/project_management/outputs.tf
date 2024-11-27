output "milestones" {
  value = [
    for milestone in var.milestones : {
      title       = milestone.title
      due_date    = milestone.due_date
      description = milestone.description
    }
  ]

  description = "The milestones created."
}
