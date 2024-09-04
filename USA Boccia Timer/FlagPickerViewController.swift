//
//  FlagPickerViewController.swift
//  USA Boccia Timer
//
//  Created by Fox on 2/12/24.
//

import Foundation
import UIKit


protocol FlagPickerViewControllerDelegate: AnyObject
{
   func flagPicker(
      _ picker: FlagPickerViewController,
      didPick flagName: String)
}

class FlagPickerViewController: UITableViewController
{

   weak var delegate: FlagPickerViewControllerDelegate?
   
   let flags = [
      "Afghanistan",
      "Aland_Islands",
      "Albania",
      "Algeria",
      "American_Samoa",
      "Andorra",
      "Angola",
      "Anguilla",
      "Antarctica",
      "Antigua_Barbuda",
      "Argentina",
      "Armenia",
      "Aruba",
      "Australia",
      "Austria",
      "Azerbaijan",
      "Bahamas",
      "Bahrain",
      "Bangladesh",
      "Barbados",
      "Belarus",
      "Belgium",
      "Belize",
      "Benin",
      "Bermuda",
      "Bhutan",
      "Bolivia",
      "Bosnia_Hertzegovina",
      "Botswana",
      "Bouvet_Island",
      "Brazil",
      "British_Indian_Ocean_Territory",
      "British_Virgin_Islands",
      "Brunei",
      "Bulgaria",
      "Burkina_Faso",
      "Burundi",
      "Cambodia",
      "Cameroon",
      "Canada",
      "Cape_Verde",
      "Caribbean_Netherlands",
      "Cayman_Islands",
      "Central_African_Republic",
      "Chad",
      "Chile",
      "China",
      "Christmas_Island",
      "Cocos_Islands",
      "Colombia",
      "Comoros",
      "Cook_Islands",
      "Costa_Rica",
      "Cote_d_Ivoire",
      "Croatia",
      "Cuba",
      "Curacao",
      "Cyprus",
      "Czechia",
      "Denmark",
      "Djibouti",
      "Dominica",
      "Dominican _Republic",
      "DR_Congo",
      "Ecuador",
      "Egypt",
      "El_Salvador",
      "England",
      "Equatorial_Guinea",
      "Eritrea",
      "Estonia",
      "Eswatini",
      "Ethiopia",
      "Falkland_Islands",
      "Faroe_Islands",
      "Fiji",
      "Finland",
      "France",
      "French_Guiana",
      "French_Polynesia",
      "French_Southern_Antarctic_Lands",
      "Gabon",
      "Gambia",
      "Georgia",
      "Germany",
      "Ghana",
      "Gibraltar",
      "Greece",
      "Greenland",
      "Grenada",
      "Guadeloupe",
      "Guam",
      "Guatemala",
      "Guernsey",
      "Guinea_Bissau",
      "Guinea",
      "Guyana",
      "Haiti",
      "Heard_Island",
      "Honduras",
      "Hong_Kong",
      "Hungary",
      "Iceland",
      "India",
      "Indonesia",
      "Iran",
      "Iraq",
      "Ireland",
      "Isle_of_Man",
      "Israel",
      "Italy",
      "Jamaica",
      "Japan",
      "Jersey",
      "Jordan",
      "Kazakhstan",
      "Kenya",
      "Kiribati",
      "Kosovo",
      "Kuwait",
      "Kyrgystan",
      "Laos",
      "Latvia",
      "Lebanon",
      "Lesotho",
      "Liberia",
      "Libya",
      "Liechtenstein",
      "Lithuania",
      "Luxembourg",
      "Madagascar",
      "Malawi",
      "Malaysia",
      "Maldives",
      "Mali",
      "Malta",
      "Marshall_Islands",
      "Martinique",
      "Mauritania",
      "Mauritius",
      "Mayotte",
      "McDonald_Islands",
      "Mexico",
      "Micronesia",
      "Moldova",
      "Monaco",
      "Mongolia",
      "Montenegro",
      "Montserrat",
      "Morocco",
      "Mozambique",
      "Mucau",
      "Myanmar",
      "Namibia",
      "Nauru",
      "Nepal",
      "Netherlands",
      "New_Caledonia",
      "New_Zealand",
      "Nicaragua",
      "Niger",
      "Nigeria",
      "Niue",
      "Norfolk_Island",
      "North_Korea",
      "North_Macedonia",
      "Northern_Ireland",
      "Northern_Mariana_Islands",
      "Norway",
      "Oman",
      "Pakistan",
      "Palau",
      "Palestine",
      "Panama",
      "Papua_New_Guinea",
      "Paraguay",
      "Peru",
      "Philippines",
      "Pitcairn_Islands",
      "Poland",
      "Portugal",
      "Puerto_Rico",
      "Qatar",
      "Republic_Congo",
      "Reunion",
      "Romania",
      "Russia",
      "Rwanda",
      "Saidi_Arabia",
      "Saint_Barthelemy",
      "Saint_Helena",
      "Saint_Kitts_Nevis",
      "Saint_Lucia",
      "Saint_Martin",
      "Saint_Pierre_Miquelon",
      "Saint_Vincent_Grenadines",
      "Samoa",
      "San_Marino",
      "Sao_Time_Principe",
      "Scotland",
      "Senegal",
      "Serbia",
      "Seychelles",
      "Sierra_Leone",
      "Singapore",
      "Sint_Maarten",
      "Slovakia",
      "Slovenia",
      "Solomon_Islands",
      "Somalia",
      "South_Africa",
      "South_Georgia",
      "South_Korea",
      "South_Sudan",
      "Spain",
      "Sri_Lanka",
      "Sudan",
      "Suriname",
      "Svalbard_Jan_Mayen",
      "Sweden",
      "Switzerland",
      "Syria",
      "Taiwan",
      "Tajikistan",
      "Tanzania",
      "Thailand",
      "Timor-Leste",
      "Togo",
      "Tokelau",
      "Tonga",
      "Trinidad_Tobago",
      "Tunisia",
      "Turkey",
      "Turkmenistan",
      "Turks_Caicos_Islands",
      "Tuvalu",
      "Uganda",
      "Ukraine",
      "United_Arab_Emirates",
      "United_Kingdom",
      "United_States_Minor_Outlying_Islands",
      "United_States_Virgin_Islands",
      "United_States",
      "Uruguay",
      "Uzbekistan",
      "Vanuatu",
      "Vatican_City",
      "Venezuela",
      "Vietnam",
      "Wales",
      "Wallis_Futuna",
      "Western_Sahara",
      "Yemen",
      "Zambia",
      "Zimbabwe"
   ]
   
   
   override func viewDidLoad()
   {
      super.viewDidLoad()
     
   }

   
    // MARK: - Table View Data Source

   override func numberOfSections(
      in tableView: UITableView) -> Int
   {
      return 1
   }

   override func tableView(
      _ tableView: UITableView, 
      numberOfRowsInSection section: Int) -> Int
   {
      return flags.count
   }

    
   override func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
      let cell = tableView.dequeueReusableCell(withIdentifier: "FlagCell", for: indexPath)
      
      let flagName = flags[indexPath.row]
      
      cell.textLabel!.text = flagName
      cell.imageView!.image = UIImage(named: flagName)
      
      return cell
   }
    
   override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath)
   {
      if let delegate = delegate
      {
	 let flagName = flags[indexPath.row]
	 delegate.flagPicker(self, didPick: flagName)
      }
   }
   
}
