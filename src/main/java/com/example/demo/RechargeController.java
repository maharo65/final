package com.example.demo;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
public class RechargeController {
    @PostMapping("/rechargement")
    public Object ajouterRecharge(@RequestBody Recharge recharge){
        try{
            Recharge.insertRecharge(recharge);
            System.out.println("insert ok");
        }catch(Exception e){
            e.printStackTrace();
            return new Error(e);
        }
        return new Data(recharge);
    }
}