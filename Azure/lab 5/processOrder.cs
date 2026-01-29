#r "Newtonsoft.Json"

using System.Net;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

public static async Task<IActionResult> Run(HttpRequest req, ILogger log)
{
    log.LogInformation("Processing order request");
    string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
    
    try
    {
        dynamic data = JsonConvert.DeserializeObject(requestBody);
        if (data == null) return new BadRequestObjectResult("Invalid request format");

        int customerId = data.CustomerID;
        var items = data.Items;
        
        // Calculate total from items
        decimal totalAmount = 0;
        foreach (var item in items)
        {
            int productId = item.ProductID;
            int quantity = item.Quantity;
            
            // For demo: Laptop=999.99, Mouse=29.99, Keyboard=79.99, Monitor=299.99
            decimal price = productId == 1 ? 999.99M : productId == 2 ? 29.99M : productId == 3 ? 79.99M : 299.99M;
            totalAmount += price * quantity;
        }

        log.LogInformation($"Order for customer {customerId} calculated. Total: {totalAmount}");

        // Return success response
        return new OkObjectResult(new 
        { 
            OrderID = 1, 
            TotalAmount = totalAmount, 
            Status = "Success", 
            Message = "Order processed successfully (demo mode - database connection will be added)" 
        });
    }
    catch (Exception ex)
    {
        log.LogError($"Error processing order: {ex.Message}");
        return new ObjectResult($"Error: {ex.Message}") { StatusCode = 500 };
    }
}