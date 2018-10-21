# Surround
## Hack Harvard 2018 Project
<img src="https://github.com/avatarneil/Surround/blob/master/surround_logo.png" align="left" height="125">
Check out our submission on Devpost! https://devpost.com/software/surround-7fyc9t
## Abstract
Every day, the world is becoming more connected; your freezer can talk to your television, your door bell can call your phone, your cat can have deep, meaningful conversations with your dog! Okay, maybe not that last one; but you get the idea. The goal of Surround is to integrate all of the IOT devices in your life with _you_, by retreiving data from Apple HealthKit, and allowing that data to control the world around you.

## Inspiration
It's 2 am, and (Charles) Neil is laying in his bed watching 90 Day Fiance... he notices one of the cast has two light switches in his bathroom, one for a dark red light, and one for a standard fluorescent bulb. He thinks, "gee, it'd be dandy to have one of those, and even nicer if I didn't have to remember which switch is which!" This was the beginning of Surround. The fundamental idea behind the application was that with all of the data about users there is available, a user should not have to _tell_ their house they're going to sleep, "Ok Google, goodnight!" Instead, the house should accommodate the user by, for example, automatically determining when they're asleep (or recently woken up), and automating tasks such as dimming lights, turning down the volume, enabling security sensors, and much more...

## What it does
This version detects whether or not you are asleep to trigger events through IFTTT integration. This trigger is also done through a toggle on the app (since we'd like to discourage actual sleeping during our demo).

## How we built it
We built a mobile app to monitor changes in HealthKit data to determine when there is a change of sleep state. The mobile app sends the changes to a backend that does light computations to manage user information. The backend, APIs, and front-end are written using Wix. We generate a temporary token to establish the initial connection between the mobile and the website. A set of APIs in the backend connect the actions to IFTTT to kick off further integrations with IoT or other services. We also used webhooks to invoke IFTTT directly through the mobile app. For the purposes of demonstration, we included a toggle that gives HealthKit mock sleep data.

## Challenges we ran into
HealthKit data is locked down when the device is locked. This makes sense but wasn't something we discovered until over half-way through the hackathon. We ended up creating a screen that just remains dark and unlocked to continue collecting data.

## Accomplishments that we're proud of
We're proud of what we are able to integrate with. Getting the IFTTT setup was difficult, but once it was complete, an entire world was open to us. The aesthetic of the app and the website is clean, and we are proud of what we did. All of us worked with new technologies and faced new challenges. Hopefully, we're better for them.

## What we learned
We learned a lot more about HealthKit and Wix. There was more javascript than any of us had worked with, and IFTTT integration have always been intriguing. We had the opportunity to dip our hands into these technologies around some amazing people, and for that, we are truly glad.

## What's next for Surround
The concept can easily be extended to include more areas within healthy, automating our worlds to our bodies. We could also move the compute more local with tools like Paradrop running household code on a wireless access point.

