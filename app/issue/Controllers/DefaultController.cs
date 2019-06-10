using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.ServiceBus.Primitives;
using Microsoft.Azure.ServiceBus.Management;

namespace issue.Controllers
{
    [Route("/")]
    [ApiController]
    public class DefaultController : ControllerBase
    {
        [HttpGet]
        public ActionResult<QueueDescription> Get()
        {
            var token = TokenProvider.CreateManagedServiceIdentityTokenProvider();           
            var client = new ManagementClient("sb://issue-6462-2083f381-sbn.servicebus.windows.net/",  token);
            var desc = client.GetQueueAsync("QueueName").Result;

            return desc;
        }
    }
}
