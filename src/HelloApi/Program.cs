var app = WebApplication.CreateBuilder(args).Build();
var version = Environment.GetEnvironmentVariable("APP_VERSION") ?? "v1";
app.MapGet("/", () => new { service = "hello-api", version, pod = Environment.MachineName });
app.MapGet("/health", () => Results.Ok("ok"));
app.Run();