variable "rg-var" {
  type = map(object(
    {
      name     = string
      location = string
    }
  ))
}
