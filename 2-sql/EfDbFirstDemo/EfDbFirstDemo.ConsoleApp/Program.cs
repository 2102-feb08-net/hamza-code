using EfDbFirstDemo.DataAccess;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace EfDbFirstDemo.ConsoleApp
{
    class Program
    {
        // Entity Framework Core
        // database-first approach steps...
        /*
         * 1. recommended: have a separate data access library project.
         * 2. install Microsoft.EntityFrameworkCore.Design and Microsoft.EntityFrameworkCore.SqlServer
         *    to the project you'll put the EF model in.
         * 3. using Git Bash / terminal, from the project folder run (split into several lines for clarity):
         *    dotnet ef dbcontext scaffold <connection-string-in-quotes>
         *      Microsoft.EntityFrameworkCore.SqlServer
         *      --force
         *      --no-onconfiguring
         *    https://docs.microsoft.com/en-us/ef/core/miscellaneous/cli/dotnet#dotnet-ef-dbcontext-scaffold
         *    (if you don't have dotnet ef installed, run: "dotnet tool install --global dotnet-ef")
         *    (this will fail if your projects do not compile)
         * 4. any time you change the structure of the tables (DDL), go to step 3.
         */
        static void Main(string[] args)
        {
            // what we just did is called "reverse engineering"
            // the overall goal is: to have c# code that can represent the DB structure & interact with it.
            // that code is called the EF model.
            //   - a class derived from DbContext.

            using var logStream = new StreamWriter("ef-logs.txt", append: false) { AutoFlush = true };
            string connectionString = File.ReadAllText("E:/Programming/revature/chinook-connection-string.txt");
            DbContextOptions<ChinookContext> options = new DbContextOptionsBuilder<ChinookContext>()
                .UseSqlServer(connectionString)
                .LogTo(action: abc => Debug.WriteLine(abc), minimumLevel: LogLevel.Information)
                .Options;
            using var context = new ChinookContext(options);

            //DemoCode(context);

            //Display5Tracks(context);

            //EditOneOfThoseTracks(context);

            //Display5Tracks();

            InsertANewTrack(context);

            //Display5Tracks();

            //DeleteTheNewTrack();

            //Display5Tracks();

            // implement some CRUD (create, read, update, delete) operations like those
            // use the reference material i've given on EF Core.

            // bonus: involve multiple tables in the operations, not just track
            // bonus: do it based on user input (Console.ReadLine)
        }

        private static void InsertANewTrack(ChinookContext context)
        {
            var artist = new Artist { Name = "Not Hamza Butt" };

            context.Artists.Add(artist);
            context.SaveChanges();

            IQueryable<Artist> query = context.Artists
                .Select(x => x)
                .Where(x => x.Name == "Not Hamza Butt");

            List<Artist> results = query.ToList();
            Console.WriteLine(results[0].ArtistId + " " + results[0].Name);
        }



        private static void EditOneOfThoseTracks(ChinookContext context)
        {
            Track track = context.Tracks.Find(1);
            track.Name = "Track name changed";
            context.SaveChanges();

            Console.WriteLine(track.Name);
        }



        private static void Display5Tracks(ChinookContext context)
        {
            IQueryable<Track> query = context.Tracks
                .Select(x => x)
                .Take(5);

            List<Track> results = query.ToList();
            Console.WriteLine(results);

            foreach(Track track in results)
            {
                Console.WriteLine(track.TrackId + " " + track.Name);
            }
        }



        static void DemoCode(ChinookContext context)
        {
            // we've seen "LINQ to Objects", when we use the IEnumerable version of LINQ methods
            var list = new List<Artist>() { null };
            Artist first = list.First();
            // this is "LINQ to SQL", the IQueryable version of LINQ methods
            // the logic of the LINQ calls is not executed in .NET at all, it's examined, translated to SQL, and executed by the SQL server
            Artist anArtist = context.Artists.FirstOrDefault(x => x.Name.Contains("sabbath"));

            IQueryable<string> query = context.Artists
                .Select(x => x.Name.ToLower())
                .Where(x => x.Length > 10)
                .Take(10);

            List<string> results = query.ToList();
        }
    }
}