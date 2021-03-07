# AnkoRP2
The second coming of AnkoRP.  Even better this time.  
Custom files optimized and organized for the second installment of AnkoRP.  

### Comments
All files have a summary of what they are at the top of the file.  
Other than that, there aren't very many comments.  

### File Location
AnkoRP_MasterAddon goes into the addons folder.  
darkrpmodification-master goes into the addons folder.  
cso_weapons_with_prices.json goes into the data folder.  

### Data File Structure
cso_weapons_with_prices.json is a JSON table with the following structure:  
* \[root table]  
     * tableKey= weapon_class:  
          * price: \[int] the price of this weapon (or upgrade)  
          * slot: \[int] the 1-based slot of this weapon  
          * parent: \[string] the weapon_class this weapon is derived of, or the string "nil" if there is none  
          * deep: \[int] what "tier" this weapon is, starts at 1  
          * model: \[string] the worldmodel of this weapon  
          * basic: \[boolean] is this weapon a "normal" weapon?  
          * name: \[string] print name of this weapon
