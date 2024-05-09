//
//  ViewController.swift
//  Karaoke
//
//  Created by student on 3/16/24.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    /*-------------
    |String Arrays|
    -------------*/
    //Songs
    var nameSongArray = [String]()
    var artistArray = [String]() // One-to-one relationship
    var genreArray = [String]()
    var durationArray = [String]()
    var albumArray = [String]()
    var albumCoverArray = [String]()
    var lyricsArray = [String]()
    var transcribedLyricsArray = [String]()
    var songMusicTitleArray = [String]()
    var favoriteArray = [String]()

    //Artists
    var nameArtist = [String]()
    var songs = [String]() // One-to-many relationship
    
    /*-------------
    |Object Arrays|
    -------------*/
    //Songs
    var nameSongObject = [NSManagedObject]()
    var artistObject = [NSManagedObject]()
    var genreObject = [NSManagedObject]()
    var durationObject = [NSManagedObject]()
    var albumObject = [NSManagedObject]()
    var albumCoverObject = [NSManagedObject]()
    var lyricsObject = [NSManagedObject]()
    var transcribedLyricsObject = [NSManagedObject]()
    var songMusicTitleObject = [NSManagedObject]()
    var favoriteObject = [NSManagedObject]()
    
    //Artists
    var nameArtistObject = [NSManagedObject]()
    var songsObject = [NSManagedObject]()
    
    /*-------
    |Strings|
    -------*/
    //Songs
    var nameSongString = "Medicate, Bodies, Dead Don't Die, Zombie, Animal I Have Become, The Pride"
    var artistString = "Theory of A Deadman, Drowning Pool, Shinedown, Bad Wolves, Three Days Grace, Five Finger Death Punch"
    var genreString = ""
    var durationInt = "235, 219, 193, 275, 230, 203"
    var albumString = "Wake Up Call, Sinner, Planet Zero, Disobey, One-X, American Capitalist"
    var albumCoverData = "theory-wake_up_call, drowning-sinner, shinedown-planet_zero, wolves-disobey, 3DG-one_x, 5FDP-american_capitalist"
    var lyricsString =
    """
    Wake up to a cloudy day Dark rolls in and it starts to rain
    Staring out to the cage-like walls Time goes by and the shadows crawl
    Crushin' Candy Crush-ing pills Got no job  mom pays my bills
    Textin'  Nexus  get my feels Sweatin' bullets  Netflix-chills
    World's out there singin' the blues Twenty more dead on the evening news
    Think to myself: really  what's the use? I'm just like you  I was born to lose
    Why oh why can't you just fix me?
    When all I want's to feel numb But the medication's all gone
    Why oh why does God hate me?
    When all I want's to get high And forget this so-called life
    I am so frickin' bored Nothing to do today
    I guess I'll sit around and medicate (I medicate)
    I am so frickin' bored Nothing to do today
    I guess I'll sit around and medicate (I medicate)
    Can't wait to feel better than I ever will Attack that shit like a kid on Benadryl
    Chase it down with a hopeful smile Hate myself  if I can go for miles
    They say family is all you need Someone to trust can help you breathe
    Inhale that drug  but you start to choke You follow the outs of an inside joke
    Why oh why can't you just fix me?
    When all I want's to feel numb But the medication's all gone
    Why oh why does God hate me?
    Cause I've seen enough of it  heard enough of it  felt enough of it I've had enough of it
    I am so frickin' bored Nothing to do today
    I guess I'll sit around and medicate (I medicate)
    I am so frickin' bored Nothing to do today
    I guess I'll sit around and medicate Medicate Medicate Medicate Medicate
    Superman is a hero But only when his mind is clear though
    He needs that fix like the rest of us So he's got no fear when he saves that bus
    All the stars in the Hollywood Hills Snapchat Live while they pop them pills
    All those flavors of the rainbow Too bad that shit don't work though
    Your friends are high right now Your parents are high right now
    That hot chick's high right now That cop is high right now
    The president's high right now Your priest is high right now
    Everyone's high as fuck right now And no one's ever coming down
    I am so frickin' bored Nothing to do today
    I guess I'll sit around and medicate (I medicate)
    I am so frickin' bored Nothing to do today
    I guess I'll sit around and medicate
    Medicate
    Medicate
    Medicate
    Medicate;Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the floor
    Let the bodies hit the...
    FLOOR!
    Beaten... why for? Can't take much more
    Here we go... Here we go... Here we go (now)
    One - Nothing wrong with me
    Two - Nothing wrong with me
    Three - Nothing wrong with me
    Four - Nothing wrong with me
    One - Something's got to give
    Two - Something's got to give
    Three - Something's got to give
    Now!
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the
    floor!
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the
    floor!
    Push  me again
    This is the end
    Here we go... Here we go... Here we go (now)
    One - Nothing wrong with me
    Two - Nothing wrong with me
    Three - Nothing wrong with me
    Four - Nothing wrong with me
    One - Something's got to give
    Two - Something's got to give
    Three - Something's got to give
    Now!
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the
    floor!
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the floor
    Skin against skin  blood and bone
    You're all by yourself  but you're not alone
    You wanted in  and now you're here
    Driven by hate  consumed by fear
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the
    floor!
    One - Nothing wrong with me
    Two - Nothing wrong with me
    Three - Nothing wrong with me
    Four - Nothing wrong with me
    One - Something's got to give
    Two - Something's got to give
    Three - Something's got to give
    Now!
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the
    floor!
    Let the bodies hit the floor Let the bodies hit the floor Let the bodies hit the
    floor
    Hey go... Hey go... Hey go... Hey go!;Black line for the 9th time
    I'm on a first name basis with the afterlife
    And there's a feeling when you're the demon
    I dug myself out of the dead for a reason
    And I'm never running  so try it again
    Starting it over right back at the end
    When's the last time you were afraid?
    I haven't been afraid a day in my life
    The dead don't die  the heart still beats
    Head held high  I haunt these streets
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die
    Knock me down six feet deep
    One more round  no reprieve
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die
    In the mirror  no reflection
    Another day  just another resurrection
    Where's the glory? Just another story
    I won't be the ending that was written for me
    And I'm never running  so try it again
    Starting it over  right where I began
    It's pretty boring is it  this existence?
    I will not take fear off the table
    The dead don't die  the heart still beats
    Head held high  I haunt these streets
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die
    Knock me down six feet deep
    One more round  no reprieve
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die
    I think everyone is a little scared of what's next
    Live or die  live or die?
    The dead don't die  the heart still beats
    Head held high  I haunt these streets
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die
    Knock me down six feet deep
    One more round  no reprieve
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die  die!
    Life's killed me a hundred thousand times
    You can try  you can try  but the dead don't die;Another head hangs lowly, Child is slowly taken
    And the violence causes silence, Who are we mistaken?
    But you see, it's not me, It's not my family
    In your head, in your head, they are fighting, With their tanks
    And their bombs and their bombs and their drones
    In your head, in your head, they are crying
    What's in your head, in your head?
    Zombie, zombie, zombie-ie-ie
    What's in your head, in your head?
    Zombie, zombie, zombie-ie-ie, oh
    Another mother's breaking heart is taking over
    When the violence causes silence
    We must be mistaken
    It's the same old theme in 2018
    In your head, in your head, they're still fighting
    With their tanks and their bombs
    And their guns and their drones
    In your head, in your head, they are dying
    What's in your head, in your head?
    Zombie, zombie, zombie-ie-ie
    What's in your head, in your head?
    Zombie, zombie, zombie-ie-ie-ie, oh
    It's the same old theme in 2018
    In your head, in your head, they are dying
    What's in your head, in your head?
    Zombie, zombie, zombie-ie-ie
    What's in your head, in your head?
    Zombie, zombie, zombie-ie-ie-ie
    Oh oh oh oh oh oh oh
    Yeah, ooh;I can't escape this hell
    So many times I've tried
    But I'm still caged inside
    Somebody get me through this nightmare
    I can't control myself
    So what if you can see the darkest side of me?
    No one would ever change this animal I have become
    Help me believe it's not the real me
    Somebody help me tame this animal
    (This animal
    this animal)
    I can't escape myself
    So many times I've lied
    But there's still rage inside
    Somebody get me through this nightmare
    I can't control myself
    So what if you can see the darkest side of me?
    No one would ever change this animal I have become
    Help me believe it's not the real me
    Somebody help me tame this animal I have become
    Help me believe it's not the real me
    Somebody help me tame this animal
    Somebody help me through this nightmare
    I can't control myself
    Somebody wake me from this nightmare
    I can't escape this hell
    This animal
    This animal
    This animal
    This animal
    This animal
    This animal
    So what if you can see the darkest side of me?
    No one will ever change this animal I have become
    Help me believe it's not the real me
    Somebody help me tame this animal I have become
    Help me believe it's not the real me
    Somebody help me tame this animal
    (This animal I have become);Hey hey hey ya Hey hey hey ya Hey hey hey ya Hey hey hey ya Hey hey hey ya Hey hey hey ya
    Johnny Cash
    And PBR
    Jack Daniels
    Nascar Facebook
    Myspace IPod Bill Gates
    Smith and Wesson
    NRA Firewater
    Pale Face Dimebag Tupac
    Heavy Metal
    Hip-Hop
    I am What you fear most
    I am What you need
    I am What you made me
    I am The American dream
    I'm not selling out I'm buying in
    I will not be forgotten
    This is my time to shine
    I've got the scars to prove it
    Only the strong survive
    I'm not afraid of dying
    Everyone has their time
    I've never favored weakness
    Welcome to the pride
    Disneyland White House JFK And Mickey Mouse
    John Wayne Springsteen Eastwood James Dean
    Coca-Cola Pepsi Playboy Text me NFL NBA Brett Favre King James
    I am All American I am Living the dream
    I am What you fear most
    I am Anarchy I'm not selling out
    I'm buying in I will not be forgotten
    This is my time to shine
    I've got the scars to prove it
    Only the strong survive I'm not afraid of dying
    Everyone has their time I've never favored weakness
    Welcome to the pride
    Since the dawn of time
    Only the strong have survived
    I will not be forgotten
    Welcome to the pride
    Hey hey hey ya
    Hey hey hey ya
    Hey hey hey ya
    Only the strong survive
    Hey hey hey ya
    Hey hey hey ya
    Hey hey hey ya
    Welcome to the pride
    I will not be forgotten This is my time to shine
    I've got the scars to prove it
    Only the strong survive
    I'm not afraid of dying
    Everyone has their time
    I've never favored weakness
    Welcome to the pride
    """
    var transcribedLyricsString =
        """
        (0:30)
        Wake up to a cloudy day, dark rolls in and it starts to rain.

        (0:34)
        Staring out at the cage like walls, time goes by and the shadows crawl.

        (0:38)
        Crushing candy, crushing pills, got no job, mom pays my bills.

        (0:42)
        Texting exes, getting my fill, sweating bullets, Netflix chills.

        (0:46)
        World's out there singing the blues, 20 more dead on the evening news.

        (0:50)
        Think to myself, really, what's the use? I'm just like you, I was born to lose.

        (0:54)
        Why oh why can't you just fix me?

        (0:58)
        When all I want's to feel numb, but the medication's all gone.

        (1:02)
        Why oh why does God hate me?

        (1:06)
        When all I want's to get high and forget this so-called life.

        (1:10)
        I am so freaking bored, nothing to do today.

        (1:14)
        I guess I'll sit around and medicate.

        (1:18)
        I am so freaking bored, nothing to do today.

        (1:22)
        I guess I'll sit around and medicate.

        (1:26)
        Can't wait to feel better than I ever will, attack that shit like a kid on Benadryl.

        (1:30)
        Chase it down with a hopeful smile, hate myself, I can go for miles.

        (1:34)
        They say family's all you need, someone to trust can help you breathe.

        (1:38)
        Inhale that drug but you start to choke, you fall on the outs of an inside joke.

        (1:42)
        Why oh why can't you just fix me?

        (1:46)
        When all I want's to feel numb, but the medication's all gone.

        (1:50)
        Why oh why does God hate me?

        (1:53)
        Cause I've seen enough of it, heard enough of it, felt enough of it, had enough of it.

        (1:58)
        I am so freaking bored, nothing to do today.

        (2:02)
        I guess I'll sit around and medicate.

        (2:06)
        I am so freaking bored, nothing to do today.

        (2:10)
        I guess I'll sit around and medicate.

        (2:38)
        Superman is a hero, but only when his mind is clear though.

        (2:42)
        He needs that fix like the rest of us, so he's got no fear when he saves that bus.

        (2:46)
        All the stars in the Hollywood hills, Snapchat live where they pop them pills.

        (2:50)
        All those flavors of the rainbow, too bad that shit don't work though.

        (2:54)
        Your friends are high right now, your parents are high right now.

        (2:58)
        That hot chick's high right now, that cop is high right now.

        (3:02)
        The president's high right now, your priest is high right now.

        (3:06)
        Everyone's high as fuck right now and no one's ever coming down.

        (3:12)
        I am so freaking bored, nothing to do today.

        (3:16)
        I guess I'll sit around and medicate.

        (3:20)
        I am so freaking bored, nothing to do today.

        (3:24)
        I guess I'll sit around and medicate.

        (3:38)
        Medicate!

        (3:40)
        Medicate!

        (3:51)
        Medicate!;
        
        
        (0:02)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the floor,

        (0:08)
        let the bodies hit the...

        (0:14)
        FLOOR!

        (0:36)
        Beaten, waffled, can't take much more.

        (0:45)
        Here we go, here we go, here we go.

        (0:47)
        One, nothing wrong with me.

        (0:49)
        Two, nothing wrong with me.

        (0:51)
        Three, nothing wrong with me.

        (0:53)
        Four, nothing wrong with me.

        (0:55)
        One, something's got to give.

        (0:56)
        Two, something's got to give.

        (0:58)
        Three, something's got to give.

        (1:00)
        NOW!

        (1:02)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the...

        (1:08)
        FLOOR!

        (1:09)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the...

        (1:20)
        FLOOR!

        (1:25)
        Push me again.

        (1:32)
        This is the end.

        (1:38)
        One, nothing wrong with me.

        (1:41)
        Two, nothing wrong with me.

        (1:42)
        Three, nothing wrong with me.

        (1:44)
        Four, nothing wrong with me.

        (1:46)
        One, something's got to give.

        (1:48)
        Two, something's got to give.

        (1:50)
        Three, something's got to give.

        (1:52)
        NOW!

        (1:54)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the...

        (2:00)
        FLOOR!

        (2:01)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the floor...

        (2:08)
        Skin on your skin, blood and bone.

        (2:12)
        You're all by yourself, but you're not alone.

        (2:15)
        You were real and now you're here.

        (2:19)
        Driven by hate, consumed by fear.

        (2:23)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the...

        (2:30)
        FLOOR!

        (2:45)
        One, nothing wrong with me.

        (2:47)
        Two, nothing wrong with me.

        (2:48)
        Three, nothing wrong with me.

        (2:50)
        Four, nothing wrong with me.

        (2:52)
        One, something's got to give.

        (2:54)
        Two, something's got to give.

        (2:56)
        Three, something's got to give.

        (2:58)
        NOW!

        (3:00)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the...

        (3:06)
        FLOOR!

        (3:07)
        Let the bodies hit the floor, let the bodies hit the floor, let the bodies hit the floor...

        (3:14)
        FLOOR!

        (3:15)
        FLOOR!

        (3:17)
        FLOOR!

        (3:18)
        FLOOR!;
        
        
        (0:07)
        Lifelines, for the ninth time

        (0:09)
        I'm on a first name basis with the afterlife

        (0:13)
        And there's no ceiling, when you're the demon

        (0:16)
        I dug myself out of the dirt for a reason

        (0:22)
        And I'm never running, so try it again

        (0:26)
        Starting me over right back at the end

        (0:29)
        When's the last time you were afraid?

        (0:32)
        I haven't been afraid a day in my life

        (0:34)
        The dead don't die, the heart still beats

        (0:38)
        Head held high, I'll haunt these streets

        (0:42)
        Lives kill me a hundred thousand times

        (0:45)
        You can try, you can try, but the dead don't die

        (0:49)
        Knock me down, six feet deep

        (0:52)
        One more round, no reprieve

        (0:56)
        Lives kill me a hundred thousand times

        (0:59)
        You can try, you can try, but the dead don't die

        (1:06)
        In the mirror, no reflection

        (1:09)
        Another day, just another resurrection

        (1:13)
        Where's the glory? Just another story

        (1:16)
        I won't be the ending that was written for me

        (1:22)
        And I'm never running, so try it again

        (1:25)
        Starting me over right back at the end

        (1:28)
        It's pretty boring, isn't it? This existence

        (1:32)
        Might as well not take a beer off the table

        (1:34)
        The dead don't die, the heart still beats

        (1:38)
        Head held high, I'll haunt these streets

        (1:41)
        Lives kill me a hundred thousand times

        (1:44)
        You can try, you can try, but the dead don't die

        (1:48)
        Knock me down, six feet deep

        (1:52)
        One more round, no reprieve

        (1:55)
        Lives kill me a hundred thousand times

        (1:58)
        You can try, you can try, but the dead don't die

        (2:02)
        I think everyone's a little scared of what's next

        (2:06)
        Live or die, live or die

        (2:23)
        The dead don't die, the heart still beats

        (2:27)
        Head held high, I'll haunt these streets

        (2:30)
        Lives kill me a hundred thousand times

        (2:33)
        You can try, you can try, but the dead don't die

        (2:37)
        Knock me down, six feet deep

        (2:41)
        One more round, no reprieve

        (2:44)
        Lives kill me a hundred thousand times

        (2:47)
        You can try, you can try, but the dead don't die

        (3:05)
        Lives kill me a hundred thousand times

        (3:08)
        You can try, you can try, but the dead don't die;
        
        
        (0:25)
        Another head hangs lowly, giant is slowly taken

        (0:37)
        And the violence causes silence, who are we mistaken?

        (0:48)
        But you see, it's not me, it's not my family

        (0:54)
        In your, they are fighting, with their tanks

        (1:03)
        And their bombs, and their bombs, and their drones

        (1:07)
        In your head, in your head

        (1:23)
        Zombie, zombie, zombie, hey, hey

        (1:29)
        What's in your head, in your head

        (1:34)
        Zombie, zombie, zombie, hey, hey, hey

        (1:43)
        Another mother's breaking, heart is taking over

        (1:55)
        When the violence causes silence, we must be mistaken

        (2:06)
        It's the same old thing in 2018

        (2:12)
        In your head, in your head

        (2:16)
        They're still fighting, with their tanks

        (2:20)
        And their bombs, and their guns, and their drones

        (2:25)
        In your head, in your head

        (2:28)
        They are dying

        (2:31)
        What's in your head, in your head

        (2:37)
        Zombie, zombie, zombie, hey, hey

        (2:44)
        What's in your head, in your head

        (2:49)
        Zombie, zombie, zombie, hey, hey, hey

        (3:21)
        It's the same old thing in 2018

        (3:27)
        In your head, in your head

        (3:30)
        They are dying

        (3:33)
        What's in your head, in your head

        (3:39)
        Zombie, zombie, zombie, hey, hey

        (3:46)
        What's in your head, in your head

        (3:52)
        Zombie, zombie, zombie, hey, hey, hey

        (4:00)
        It's the same old thing in 2018;
        
        
        (0:24)
        I can't escape this hell.

        (0:32)
        So many times I've tried.

        (0:40)
        But I'm still caged inside.

        (0:47)
        Somebody get me through this nightmare.

        (0:52)
        I can't control myself.

        (0:55)
        And so what if you can see the darkest side of me?

        (0:59)
        No, I'll never change this animal I have become.

        (1:04)
        Help me believe it's not the real me.

        (1:07)
        Somebody help me tame this animal.

        (1:12)
        This animal.

        (1:14)
        This animal.

        (1:15)
        I can't escape myself.

        (1:23)
        So many times I've lied.

        (1:31)
        But there's still rage inside.

        (1:38)
        Somebody get me through this nightmare.

        (1:43)
        I can't control myself.

        (1:47)
        And so what if you can see the darkest side of me?

        (1:50)
        No, I'll never change this animal I have become.

        (1:55)
        Help me believe it's not the real me.

        (1:58)
        Somebody help me tame this animal I have become.

        (2:03)
        Help me believe it's not the real me.

        (2:06)
        Somebody help me tame this animal.

        (2:12)
        Somebody help me through this nightmare.

        (2:16)
        I can't control myself.

        (2:20)
        Somebody wake me from this nightmare.

        (2:24)
        I can't escape this animal.

        (2:32)
        This animal.

        (2:34)
        This animal.

        (2:38)
        This animal.

        (2:40)
        This animal.

        (2:42)
        This animal.

        (2:44)
        This animal.

        (2:47)
        So what if you can see the darkest side of me?

        (2:52)
        No, I will never change this animal I have become.

        (2:56)
        Help me believe it's not the real me.

        (2:59)
        Somebody help me tame this animal I have become.

        (3:04)
        Help me believe it's not the real me.

        (3:07)
        Somebody help me tame this animal.

        (3:17)
        This animal I have become.;
        
        
        (0:10)
        Hey
        
        (0:27)
        Johnny
        
        (0:33)
        catch up in the yard.
        
        (0:34)
        Jack Daniels,
        
        (0:34)
        NASCAR, Facebook,
        
        (0:36)
        myspace, iPod, Bill Gates,
        
        (0:37)
        Smith & Wesson,
        
        (0:38)
        NRA, Firewater,
        
        (0:39)
        Vail, Major Don,
        
        (0:40)
        Back to Flock,
        
        (0:41)
        Heavy Metal,
        
        (0:41)
        Hip Hop,
        
        (0:51)
        I'm not selling out, I'm buying in I will not be forgotten, this is my time to
        
        (1:00)
        shine I've got the scars to prove that only the
        
        (1:04)
        strong survive I'm not afraid of dying, everyone has their
        
        (1:09)
        time Life never favored me, welcome to the pride
        
        (1:23)
        Disneyland, White House, JFK and Mickey Mouse John Wayne, Springsteen, Eastwood, Chainstein
        
        (1:28)
        Coca-Cola, Pepsi, Playboy, Jaxby NFL, NBA, Brett Favre, T.J.
        
        (1:33)
        I am All-American
        
        (1:35)
        I am Living the dream
        
        (1:37)
        I am What you fear most
        
        (1:40)
        I am Anarchy
        
        (1:42)
        I'm not selling out, I'm buying in
        
        (1:46)
        I will not be forgotten, this is my time to shine
        
        (1:51)
        I've got the scars to prove that only the strong survive
        
        (1:56)
        I'm not afraid of dying, everyone has their time
        
        (2:00)
        Life never favored me, welcome to the pride
        
        (2:09)
        Since the dawn of time, only the strong have survived
        
        (2:14)
        I will not be forgotten
        
        (2:16)
        Welcome to the pride
        
        (2:48)
        Only the strong survive
        
        (2:51)
        Yeah, yeah, yeah
        
        (2:58)
        Welcome to the pride
        
        (3:00)
        I will not be forgotten, this is my time to shine
        
        (3:05)
        I've got the scars to prove that only the strong survive
        
        (3:10)
        I'm not afraid of dying, everyone has their time
        
        (3:14)
        Life never favored me, welcome to the pride


        """
    var songMusicTitleString = "theory-rx-medicate-official-video-128-ytshorts.savetube.me-Music, drowning-pool-bodies-128-ytshorts.savetube.me_Instrumental, shinedown-dead-don-t-die-official-video-128-ytshorts.savetube.me_Instrumental, bad-wolves-zombie-official-video-128-ytshorts.savetube.me_Instrumental, three-days-grace-animal-i-have-become-128-ytshorts.savetube.me_Instrumental, five-finger-death-punch-the-pride-official-audio-128-ytshorts.savetube.me_Instrumental"
    var favoriteString = "false, false, false, false, false, false"
    
    //Artists
    var nameArtistString = ""
    var songsString = ""
    
    var songsArray: [Song] = []
    var selectedSong: Song?

    var dataManager: NSManagedObjectContext!
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewControllerStack: [UIViewController] = []
    var vcStack: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register CustomCell class or XIB file with the table view
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customcell_id")
        
        // Print out the details of the selected song
        if let selectedSong = selectedSong {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            dataManager = appDelegate.persistentContainer.viewContext
            
            let fetchResult: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Songs")

            do {
                let result = try dataManager.fetch(fetchResult)
                favoriteString = ""
                let songs = result as! [NSManagedObject]

                for song in songs {
                    if let favorite = song.value(forKey: "favorite") as? String {
                        if !favorite.isEmpty {
                            if !favoriteString.isEmpty {
                                favoriteString += ", "
                            }
                            favoriteString += favorite
                        } else {
                            favoriteString += "false"
                        }
                    } else {
                        favoriteString += "false"
                    }
                }
            }
            catch {
                print("Error retrieving the data")
            }
            
            var song = selectedSong.title
            let favorite = selectedSong.favorite
            song = song.trimmingCharacters(in: .whitespaces)
            
            // Split the string by commas
            let songTitles = nameSongString.components(separatedBy: ", ")

            // Find the index of song
            if let index = songTitles.firstIndex(of: song) {
                var favorites = favoriteString.components(separatedBy: ", ")
                favorites[index] = favorite.trimmingCharacters(in: .whitespaces)
                favoriteString = favorites.joined(separator: ", ")
            } else {
                print("Song not found in the string.")
            }
        } else {
            //No Song Selected
        }
        
        saveData()
        fetchData()
    }
    
    //Save data to database
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Songs")
        
        do {
            let songs = try dataManager.fetch(fetchRequest) as! [NSManagedObject]
            
            // Check if there are existing songs
            if let existingSong = songs.first {
                // Update existing song with new values
                existingSong.setValue(nameSongString, forKey: "name")
                existingSong.setValue(artistString, forKey: "artist")
                existingSong.setValue(genreString, forKey: "genre")
                existingSong.setValue(durationInt, forKey: "duration")
                existingSong.setValue(albumString, forKey: "album")
                existingSong.setValue(albumCoverData, forKey: "album_cover")
                existingSong.setValue(lyricsString, forKey: "lyrics")
                existingSong.setValue(transcribedLyricsString, forKey: "transcribed_lyrics")
                existingSong.setValue(songMusicTitleString, forKey: "song_music_title")
                existingSong.setValue(favoriteString, forKey: "favorite")
            } else {
                // If no existing song, insert a new one
                let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Songs", into: dataManager)
                newEntity.setValue(nameSongString, forKey: "name")
                newEntity.setValue(artistString, forKey: "artist")
                newEntity.setValue(genreString, forKey: "genre")
                newEntity.setValue(durationInt, forKey: "duration")
                newEntity.setValue(albumString, forKey: "album")
                newEntity.setValue(albumCoverData, forKey: "album_cover")
                newEntity.setValue(lyricsString, forKey: "lyrics")
                newEntity.setValue(transcribedLyricsString, forKey: "transcribed_lyrics")
                newEntity.setValue(songMusicTitleString, forKey: "song_music_title")
                newEntity.setValue(favoriteString, forKey: "favorite")
            }
            
            try dataManager.save()
        } catch {
            print("Error saving the data")
        }
        
//        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Songs", into: dataManager)
//        newEntity.setValue(nameSongString, forKey: "name")
//        newEntity.setValue(artistString, forKey: "artist")
//        newEntity.setValue(genreString, forKey: "genre")
//        newEntity.setValue(durationInt, forKey: "duration")
//        newEntity.setValue(albumString, forKey: "album")
//        newEntity.setValue(albumCoverData, forKey: "album_cover")
//        newEntity.setValue(lyricsString, forKey: "lyrics")
//        newEntity.setValue(transcribedLyricsString, forKey: "transcribed_lyrics")
//        newEntity.setValue(songMusicTitleString, forKey: "song_music_title")
//        newEntity.setValue(favoriteString, forKey: "favorite")
//
//        do {
//            try self.dataManager.save()
//
//            nameSongObject.append(newEntity)
//            artistObject.append(newEntity)
//            genreObject.append(newEntity)
//            durationObject.append(newEntity)
//            albumObject.append(newEntity)
//            albumCoverObject.append(newEntity)
//            lyricsObject.append(newEntity)
//            transcribedLyricsObject.append(newEntity)
//            songMusicTitleObject.append(newEntity)
//            favoriteObject.append(newEntity)
//        }
//        catch {
//            print("Error saving the data")
//        }
    }
    
    //Fetch data from database
    func fetchData() {
        let fetchResult: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Songs")
        
        do {
            let result = try dataManager.fetch(fetchResult)
            let songs = result as! [NSManagedObject]
            
            for song in songs {
                if let nameSong = song.value(forKey: "name") as? String {
                    nameSongArray = nameSong.components(separatedBy: ",")
                }
                else {
                }
                if let artist = song.value(forKey: "artist") as? String {
                    artistArray = artist.components(separatedBy: ",")
                }
                else {
                }
                if let genre = song.value(forKey: "genre") as? String {
                    genreArray = genre.components(separatedBy: ",")
                }
                else {
                }
                if let duration = song.value(forKey: "duration") as? String {
                    durationArray = duration.components(separatedBy: ",")
                }
                else {
                }
                if let album = song.value(forKey: "album") as? String {
                    albumArray = album.components(separatedBy: ",")
                }
                else {
                }
                if let albumCover = song.value(forKey: "album_cover") as? String {
                    albumCoverArray = albumCover.components(separatedBy: ",")
                }
                else {
                }
                if let lyrics = song.value(forKey: "lyrics") as? String {
                    lyricsArray = lyrics.components(separatedBy: ";")
                }
                else {
                }
                if let transcribedLyrics = song.value(forKey: "transcribed_lyrics") as? String {
                    transcribedLyricsArray = transcribedLyrics.components(separatedBy: ";")
                }
                else {
                }
                if let songMusicTitle = song.value(forKey: "song_music_title") as? String {
                    songMusicTitleArray = songMusicTitle.components(separatedBy: ",")
                }
                else {
                }
                if let favorite = song.value(forKey: "favorite") as? String {
                    favoriteArray = favorite.components(separatedBy: ",")
                }
                else {
                }
            }
            let zipped = zip(nameSongArray, zip(artistArray, zip(albumCoverArray, zip(lyricsArray, zip(songMusicTitleArray, zip(durationArray, zip(transcribedLyricsArray, favoriteArray)))))))
            
            for (name, (artist, (album, (lyrics, (songMusicTitle, (duration, (transcribedLyrics, favorite))))))) in zipped {
                let allSongs = Song(title: name, subtitle: artist, album: album, lyrics: lyrics, transcribedLyrics: transcribedLyrics, songMusicTitle: songMusicTitle, duration: duration, favorite: favorite)
                
                songsArray.append(allSongs)
            }
        }
        catch {
            print("Error retrieving the data")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell_id", for: indexPath) as! CustomCell
        let item = songsArray[indexPath.row]
        
        cell.songName?.text = item.title
        cell.artistName?.text = item.subtitle
        cell.albumCover?.image = UIImage(named: item.album.trimmingCharacters(in: .whitespacesAndNewlines))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func pushViewController(_ viewController: UIViewController, _ viewControllerSelectedSong: UIViewController) {
        viewControllerStack.append(viewController)
        viewControllerStack.append(viewControllerSelectedSong)
        print("pushVC: \(viewControllerStack)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let currentVC = storyboard.instantiateViewController(withIdentifier: "songs_id")
        let selectedSongVC = storyboard.instantiateViewController(withIdentifier: "selectedSong_id") as! SelectedSongViewController
        selectedSongVC.selectedSong = songsArray[indexPath.row]
        pushViewController(currentVC, selectedSongVC)
        selectedSongVC.vcStack = viewControllerStack[0]
        view.addSubview(selectedSongVC.view)
        selectedSongVC.didMove(toParent: self)
        print("didSelectRowAfterPush: \(viewControllerStack)")
    }
    
    @IBAction func openDrawer(_ sender: UIBarButtonItem) {
        let drawerViewController = DrawerMenuViewController()
        drawerViewController.songsArray = songsArray
        present(drawerViewController, animated: true)
    }
    
    @IBAction func searchSongs(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Search For A Song", message: "Enter A Song Name", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {
            (textField) in textField.placeholder = "Song Name"
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            action -> Void in
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
