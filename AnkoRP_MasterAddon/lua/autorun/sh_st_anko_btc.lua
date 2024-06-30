--[[
    Poll the CoinDesk API every minute to update Bitcoin price.
]]--

STBTC2_PRICE = 0.0

if SERVER then 

    util.AddNetworkString( "STBTC2UpdatePrice" )

    hook.Add( "InitPostEntity", "StartUpdatingBTCPrice2", function()
        local btctab = {}
        local btcprice = 0
            
        http.Fetch( "https://api.coindesk.com/v1/bpi/currentprice/usd.json",
                    
            function( body, len, headers, code )
                btctab = util.JSONToTable( body )
                btcprice = btctab.bpi.USD.rate_float
                net.Start("STBTC2UpdatePrice")
                    net.WriteFloat( btcprice )
                net.Broadcast()
                STBTC2_PRICE = btcprice
            end,
                    
            function(err)
                net.Start("STBTC2UpdatePrice")
                    net.WriteFloat( 0.0 )
                net.Broadcast()
                STBTC2_PRICE = 0
            end 
        )
            
        timer.Create( "BTCPriceUpdate", 60, 0, function()

            http.Fetch( "https://api.coindesk.com/v1/bpi/currentprice/usd.json",
                    
                function( body, len, headers, code )
                    btctab = util.JSONToTable( body )
                    btcprice = btctab.bpi.USD.rate_float
                    net.Start("STBTC2UpdatePrice")
                        net.WriteFloat( btcprice )
                    net.Broadcast()
                    STBTC2_PRICE = btcprice
                end,
                    
                function(err)
                    net.Start("STBTC2UpdatePrice")
                        net.WriteFloat( 0.0 )
                    net.Broadcast()
                    STBTC2_PRICE = 0
                end 
            )
        end )

    end )
end

if CLIENT then
    net.Receive( "STBTC2UpdatePrice", function()
        local pric = net.ReadFloat()
        STBTC2_PRICE = math.Round( pric, 4 )
    end )
end