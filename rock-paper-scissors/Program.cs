using System;

namespace rock_paper_scissors
{
    class Program
    {
        static void Main(string[] args)
        {
            RPS rps = new RPS();

            Console.WriteLine("Pick a choice:");

            //user picks a choice
            rps.UserChoice = Console.ReadLine();
            
            //play the game
            string result = rps.Play();

            Console.WriteLine(result);
        }
    }
}
