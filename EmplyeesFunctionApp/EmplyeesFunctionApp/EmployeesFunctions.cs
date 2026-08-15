using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace EmplyeesFunctionApp;

public class EmployeesFunctions
{
    private readonly ILogger<EmployeesFunctions> _logger;

    public EmployeesFunctions(ILogger<EmployeesFunctions> logger)
    {
        _logger = logger;
    }

    [Function("GetEmployees")]
    public IActionResult GetEmployees([HttpTrigger(AuthorizationLevel.Function, "get")] HttpRequest req)
    {
        var employees = new List<string> { "Bhogyari", "Karunakar" };
        return new OkObjectResult(employees);
    }
}