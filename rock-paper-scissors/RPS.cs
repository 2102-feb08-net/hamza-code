using System;

namespace rock_paper_scissors
{
    public class RPS
    {
        private string _userChoice;

        public string UserChoice
        {
            get {return _userChoice;}
            set
            {
                // if(string.Equals(value, "rock", StringComparison.OrdinalIgnoreCase))
                // {

                // }
                _userChoice = value;
            }
        }

        public string Play()
        {
            Array choices = Enum.GetValues(typeof (Choices));
            Random random = new Random();
            Choices randomChoice = (Choices)choices.GetValue(random.Next(choices.Length));
            string computerChoice = randomChoice.ToString();

            switch(_userChoice)
            {
                case "rock":
                    switch(computerChoice)
                    {
                        case "rock":
                            return "Draw";
                        case "paper":
                            return "You Lose";
                        case "scissors":
                            return "You Win";
                    }
                break;

                case "paper":
                    switch(computerChoice)
                    {
                        case "rock":
                            return "You Win";
                        case "paper":
                            return "Draw";
                        case "scissors":
                            return "You Lose";
                    }
                break;

                case "scissors":
                    switch(computerChoice)
                    {
                        case "rock":
                            return "You Lose";
                        case "paper":
                            return "You Win";
                        case "scissors":
                            return "You Lose";
                    }
                break;

            }

            return $"Valid inputs are \"rock\", \"paper\", \"scissors\" ";
        }
    }
}